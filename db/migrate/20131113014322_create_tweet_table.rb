class CreateTweetTable < ActiveRecord::Migration
  def up
  	create_table :tweets do |n|
  		n.string :tweet_text
  		n.datetime :tweet_time
  	end
  end

  def down
  	drop_table :tweets
  end

end
