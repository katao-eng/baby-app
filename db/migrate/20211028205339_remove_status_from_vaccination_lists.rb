class RemoveStatusFromVaccinationLists < ActiveRecord::Migration[6.0]
  def change
    remove_column :vaccination_lists, :status, :boolean
  end
end
