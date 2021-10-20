class CreateVaccines < ActiveRecord::Migration[6.0]
  def change
    create_table :vaccines do |t|

      t.timestamps
      t.string  :name,    null: false
      t.integer :kind_id, null: false
    end
  end
end
