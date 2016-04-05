class TweetsController < ApplicationController
	def new
		current_user.twitter
	end

	def show
	  @tweets = current_user.twitter.user_timeline	
	  binding.pry
	end


end
