require 'spec_helper'

describe UsersController do
	render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have right title " do
    	get 'new'
    	response.should have_selector("title" , :content =>"Sign up" )
    end
    
  end
  
  describe "Get 'show' " do
  	
  	   before(:each) do  	   	
  	   	@user = Factory(:user)
  	   	User.stub!(:find, @user.id).and_return(@user)
  	   end
  	   
  	   it "should be successful " do
  	   	get 'show', :id =>@user
  	   	response.should be_success
  	   end
  	   
  	   it "should have right title  " do
  	   	get 'show', :id =>@user
  	   	response.should have_selector("title", :content =>@user.name)
  	   end
  	   
  	   it "should include the user's name" do
  	   	get 'show', :id =>@user
  	   	response.should have_selector("h1", :content =>@user.name)
  	   end
  	   
  	   it "should have a profile image " do
  	   	get 'show', :id =>@user
  	   	response.should have_selector("h1>imag",:class => "gravatar")
  	   end
  	   
  	   
  end

end
