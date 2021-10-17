class CreateBabies < ActiveRecord::Migration[6.0]
  def change
    create_table :babies do |t|

      t.timestamps
      t.string     :nickname, null: false
      t.date       :birthday, null: false
      t.references :user,     null: false, foreign_key: true
    end
  end
end
