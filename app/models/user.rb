class User < ActiveRecord::Base
	has_many :searches
	accepts_nested_attributes_for :searches

	#returns a user object from the returned authorization hash
	def self.find_or_create_from_auth_hash(auth_hash)
		user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
		user.update(
			name: auth_hash.info.name,
			profile_image: auth_hash.info.image,
			handle: auth_hash.info.nickname,
			token: auth_hash.credentials.token,
			secret: auth_hash.credentials.secret
			)
		user
	end

	#create authorization token
	def twitter
		  #checks for existing client or makes a new session with a oauth token request
  		@client ||= Twitter::REST::Client.new do |config|
	    	config.consumer_key        = Rails.application.secrets.twitter_public_key
		    config.consumer_secret     = Rails.application.secrets.twitter_secret_key
		    config.access_token        = token
		    config.access_token_secret = secret
  		end
	end


end
