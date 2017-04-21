require "rails_helper"
require "Time"

RSpec.describe Search, :type => :controller do
  before :all do
    
  end

  describe "#get_search_from_database" do
    it "gets a search object from the database" do
      auth_hash = @fake_auth_hash
      expect(create).to redirect_to "http://localhost:3000/search/create.pearloscopy"
    end
  end

end






