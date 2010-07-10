require 'spec_helper'

describe SessionsController do
	render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have right title " do
    	get 'new'
    	response.should have_selector("title", :content => "Sign in" )
	end
	
  end
  
  describe "POST 'create'" do
  	
  	describe "invalid signin" do
  		before(:each) do
  			@attr = {:email =>"email@example.com",:password =>"password" }
  			User.should_receive(:authenticate).with(@attr[:email],@attr[:password]).
  			and_return(nil)
  		end
  		
  		it "should re-render new page" do
  			post :create ,:session =>@attr
  			response.should render_template('new') 
  		end 			
  		
  		it "shoud have the right title" do
  			post :create ,:session =>@attr
  			response.should have_selector("title", :content =>"Sign in")
  		end
  	end
  	
  	describe "with valid email and password" do
  		
  		before(:each) do
  			@user =Factory(:user)
  			@attr = { :email => @user.email, :password => @user.password }
  			User.should_receive(:authenticate).
  			     with(@attr[:email],@attr[:password]).
  			     and_return(@user)
  		end
  		
  		it "should sign in the user" do
  			post :create, :session => @attr
  			controller.current_user.should == @user
			controller.should be_signed_in
  		end
  		
  		it "should redirect to the user show page" do
  			post :create, :session => @attr
  			redirect_to user_path(@user)
  		end
  		
  	end
  	  	
  end
  
  describe "DELETE 'destroy'" do
  	it "should sign a user out" do
  		test_sign_in(Factory(:user))
		controller.should_receive(:sign_out)
		delete :destroy
		response.should redirect_to(root_path)
	end
  end

end
