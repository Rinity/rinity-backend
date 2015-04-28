class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    User.all.each do |user|
      user.generate_authentication_token
      user.save
    end
  end
end
