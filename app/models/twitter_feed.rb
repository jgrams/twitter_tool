class TwitterFeed < ActiveRecord::Base
	validates :twitter_handle, presence: true
end
