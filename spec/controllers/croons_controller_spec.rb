require File.dirname(__FILE__) + '/../spec_helper'

describe CroonsController do

  describe "GET 'index'" do
    it "should be successful" do
      Croon = mock
      Croon.stub!(:all).return([])
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
#      get 'create'
#      response.should be_success
    end
  end

  describe "GET 'crooning'" do
    it "should be successful" do
#      get 'crooning'
#      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
#      get 'show'
#      response.should be_success
    end
  end

end
