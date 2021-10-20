class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.time :time
      t.string :visitor_name
      t.boolean :is_video
      t.string :note

      t.timestamps
    end
  end
end
