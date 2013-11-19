class User < ActiveRecord::Base
	has_many :tweets
end

class Tweets < ActiveRecord::Base
	belongs_to :user
end