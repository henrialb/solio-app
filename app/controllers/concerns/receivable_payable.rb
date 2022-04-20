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
end
