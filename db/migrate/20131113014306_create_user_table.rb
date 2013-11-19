class CreateUserTable < ActiveRecord::Migration
  def up
  	create_table :users do |n|
  		n.string :fname
  		n.string :lname
  		n.string :email
      n.string :username
  		n.string :password
  	end
  end

  def down
  	drop_table :users
  end

end
