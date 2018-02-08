class AddfilialeToFirms < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :daughter_localisation, :string
  end
end
