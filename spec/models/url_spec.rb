require 'spec_helper'

describe Url do
 
  context "when creating a new shortened url" do

    it "should be valid with a supplied url"  do
      @url = Url.new(:url =>  'http://google.com')
      @url.should be_valid
    end

    it "should be invalid without a supplied url"  do
      @url = Url.new(:url =>  nil)
      @url.should_not be_valid
    end

    it "should be invalid with an invalid url"  do
      @url = Url.new(:url =>  'http://test.steve')
      @url.should_not be_valid
    end

  end

end
