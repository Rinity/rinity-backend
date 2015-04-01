class AddDefaultOfficeToUser < ActiveRecord::Migration
  def change
    add_reference :users, :default_office, index: true
    add_foreign_key :users, :default_offices
  end
end
