class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :direction
      t.datetime :time
      t.string :type
      t.integer :freeSeats
      t.string :fromAddress
      t.string :toAddress
      t.string :fromCity
      t.string :toCity
      t.integer :user_id
      t.string :status
      t.integer :ride_id

      t.timestamps null: false
    end
  end
end
