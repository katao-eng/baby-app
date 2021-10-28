class CreateVaccinationLists < ActiveRecord::Migration[6.0]
  def change
    create_table :vaccination_lists do |t|

      t.timestamps
      t.date       :date
      t.date       :start_date, null: false
      t.date       :end_date,   null: false
      t.references :baby,       null: false, foreign_key: true
      t.references :vaccine,    null: false, foreign_key: true
    end
  end
end
