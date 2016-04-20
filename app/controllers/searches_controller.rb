class SearchesController < ApplicationController
  def create
    #collect the most recent 200 tweets, returned as an array
    @search = current_user.searches.new(search_params)
    if @search.save
      redirect_to tweet_show_path(search_params)
      else
        binding.pry
    end
  end

  private

  def search_params
    params.require(:search).permit(:username)
  end

end
