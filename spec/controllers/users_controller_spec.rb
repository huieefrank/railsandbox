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
  	   	response.should have_selector("h1>img",:class => "gravatar")
  	   end
  	   
  	   
  end
  
  describe "POST 'create'" do
  	
  	describe "failure" do
  		before(:each) do
  			@attr = { :name => "", :email => "", :password => "",
						:password_confirmation => "" }
			@user = Factory.build(:user, @attr)
			User.stub!(:new).and_return(@user)
			@user.should_receive(:save).and_return(false)
		end
		
		it "should have the right title" do
			post :create, :user => @attr
			response.should have_selector("title", :content => "Sign up")
		end
		
		it "should render the 'new' page" do
			post :create, :user => @attr
			response.should render_template('new')
		end 		
  		
  	end  	
  	
  	describe "success" do
		before(:each) do
			@attr = { :name => "New User", :email => "user@example.com",
						:password => "foobar", :password_confirmation => "foobar" }
			@user = Factory(:user, @attr)
			User.stub!(:new).and_return(@user)
			@user.should_receive(:save).and_return(true)
		end
		
		it "should redirect to the user show page" do
			post :create, :user => @attr
			response.should redirect_to(user_path(@user))
		end
		
		it "should have a welcome message" do
			post :create, :user => @attr
			flash[:success].should =~ /welcome to the sample app/i
		end
		
		it "should sign the user in " do
			post :create , :user =>@user
			controller.should be_signed_in
		end
		
	end
  	
  end
  
end
