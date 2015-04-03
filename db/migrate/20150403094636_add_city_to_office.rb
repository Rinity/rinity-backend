class AddCityToOffice < ActiveRecord::Migration
  def change
    add_column :offices, :city, :string
  end
end
