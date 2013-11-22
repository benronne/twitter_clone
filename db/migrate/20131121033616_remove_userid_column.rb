class RemoveUseridColumn < ActiveRecord::Migration
  def up
 	remove_column :tweets, :userid, :integer
  end
	
  def down
  	add_column :tweets, :userid, :integer
  end
end