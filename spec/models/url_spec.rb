require 'spec_helper'

describe Url do
 
  context "when generating an identifier for a new shortened url" do

    it "should convert decimal to base62" do
      Url.convert_to_base62(42692).should eql('B6a')
    end

    it "should convert the base62 to decimal" do
      Url.convert_from_base62('eZe').should eql(155970)
    end

  end

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
