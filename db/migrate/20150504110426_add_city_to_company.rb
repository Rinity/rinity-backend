class AddCityToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :city, :string
    Company.update_all(city: 'Debrecen')
  end
end
