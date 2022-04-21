module ReceivablePayable
  def pay_outstanding_receivables(patient, additional_funds = 0, patient_payment_id = nil)
    receivables = PatientReceivable.where(patient_id: patient).unpaid.personal.to_a

    target_receivable = receivables.extract! { |receivable| receivable.amount == additional_funds }

    unless target_receivable.empty?
      target_receivable.first.update(status: :paid, patient_payment_id: patient_payment_id)
    else
      funds = patient.balance + additional_funds

      ActiveRecord::Base.transaction do
        receivables.each do |receivable|
          next if funds < receivable.amount

          receivable.update(status: :paid, patient_payment_id: patient_payment_id)
          funds -= receivable.amount
        end

        patient.update(balance: funds) if funds != patient.balance
      end
    end
  end

  def pay_scml_receivables(patient, funds, patient_payment_id = nil)
    receivables = PatientReceivable.where(patient_id: patient).unpaid.scml.to_a

    if receivables.length == 1
      receivable = receivables.first

      receivable.update(status: :paid, patient_payment_id: patient_payment_id) if receivable.amount == funds
    else
      if receivables.any? { |receivable| receivable.amount == funds }
        # There are multiple unpaid receivables but at least one matches the payment amount
        target_receivable = receivables.extract! { |receivable| receivable.amount == funds }

        target_receivable.first.update(status: :paid, patient_payment_id: patient_payment_id)
      else
        # No receivable matches the payment amount. Maybe combinations do?
        full_combinations = []

        (2..receivables.length).each do |i|
          combinations = receivables.combination(i).to_a

          combinations.each do |combination|
            amount = combination.sum(&:amount)

            full_combinations << { amount: amount, combination: combination }
          end
        end

        target_combination = full_combinations.extract! { |combination| combination[:amount] == funds }

        return false if target_combination.empty?

        ActiveRecord::Base.transaction do
          target_combination.first[:combination].each do |receivable|
            receivable.update(status: :paid, patient_payment_id: patient_payment_id)
          end
        end
      end
    end
  end
end
