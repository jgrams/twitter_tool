class ExampleController < ApplicationController
  def show_random
    @example = Example.order("RANDOM()").first
  end
end
