require 'spec_helper'

describe "Users" do
	
  describe "Signup" do
  	
  	describe "failure" do
  		
  		it "should not make a new user" do
  			lambda do
  				visit signup_path
  				click_button
  				response.should render_template('users/new')
  				response.should have_selector("div#error_explanation")
  			end.should_not change(User, :count)
  		end
    end
    
    describe "success" do
    	after(:each) do
    		User.delete_all
    	end
		it "should make a new user" do
			lambda do
				visit signup_path
				fill_in "Name", :with => "Example User"
				fill_in "Email", :with => "user@example.com"
				fill_in "Password", :with => "foobar"
				fill_in "Confirmation", :with => "foobar"
				click_button
				response.should render_template('users/show')
			end.should change(User, :count).by(1)
		end
	end
    
    
  end
  
end
