class AddUseridToTweets < ActiveRecord::Migration
  def up
 	add_column :tweets, :userid, :integer
  end
	
  def down
  	remove_column :tweets, :userid, :integer
  end
end
