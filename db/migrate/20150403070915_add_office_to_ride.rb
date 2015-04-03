class AddOfficeToRide < ActiveRecord::Migration
  def change
    add_reference :rides, :office, index: true
    add_foreign_key :rides, :offices
  end
end
