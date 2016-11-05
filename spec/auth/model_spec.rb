require 'rails_helper'
require 'auth/model'

class ModelHelperTest
  include Auth::Model
end

describe Auth::Model do
  before :each do 
    @model_helper = ModelHelperTest.new
  end

  describe "Password Encryption" do
    it "#generate_hex_pair should return hex'ed password with salt and peper" do
      pair = @model_helper.generate_hex_pair("testPassword")
      expect(pair[:salt]).not_to be_nil
      expect(pair[:hex]).not_to be_nil
    end
  end

end