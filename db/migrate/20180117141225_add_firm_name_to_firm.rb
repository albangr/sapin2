class AddFirmNameToFirm < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :firm_name, :string
  end
end
