require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
  	it "should have the content 'Pollster'" do
  	  visit '/static_pages/home'
  	  page.should have_selector('h1', :text => 'Pollster')
  	end
  end

  describe "About page" do
  	it "should have the content 'About'" do
  	  visit '/static_pages/about'
  	  page.should have_selector('h1', :text => 'About')
  	end
  end

  describe "Help page" do
  	it "should have the content 'Help'" do
  	  visit '/static_pages/help'
  	  page.should have_selector('h1', :text => 'Help')
  	end
  end
end
