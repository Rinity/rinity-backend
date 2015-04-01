class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name
      t.string :address
      t.belongs_to :company, index: true

      t.timestamps null: false
    end
    add_foreign_key :offices, :companies
  end
end
