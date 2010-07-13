require 'spec_helper'

describe "LayoutLinks" do
 it "should have a home page at '/' " do
 	get '/'
 	response.should have_selector('title', :content => "Home")
 end
 
 it "should have a contact page at '/contact' " do
 	get '/contact'
 	response.should have_selector('title', :content =>"Contact")
 end
 
 it "should have a about pages at '/about' " do
 	get '/about'
 	response.should have_selector("title", :content =>"About")
 end
 
 it "should have a help page at '/help' " do
 	get '/help'
 	response.should have_selector("title",:content =>"Help")
 end
 
 it "should have a sign up page at '/signup' " do
 	get '/signup'
 	response.should have_selector("title", :content =>"Sign up")
 end
 
 it "should have the right links on layout  " do
 	visit root_path
 	click_link "About"
 	response.should have_selector("title", :content =>"About")
 	click_link "Help"
 	response.should have_selector("title", :content => "Help")
 	click_link "Contact"
 	response.should have_selector("title" ,:content =>"Contact")
 	click_link "Sign up now!"
 	response.should have_selector("title" , :content => "Signup")
 end
 
 
 describe "when not signed in" do
 	it "should have a sign link " do 
 		visit root_path
 		response.should have_selector("a", :href => signin_path, :content =>"Sign in")
 	end
 	 
 end
 
 describe "when signed in" do
 	
 	
 	it "should have a signout link" do
 		lambda do
				visit signup_path
				fill_in "Name", :with => "Frank"
				fill_in "Email", :with => "frank@sina.com"
				fill_in "Password", :with => "foobar"
				fill_in "Confirmation", :with => "foobar"
				click_button
				response.should render_template('users/show')
			end.should change(User, :count).by(1)
 		visit root_path
 		response.should have_selector("a", :href =>signout_path , :content =>"Sign out")
 	end
 	
 	it "should have a profile link " do 
 		visit root_path
 		response.should have_selector("a" ,:href => user_path(@user),
 		                                   :content =>"	profile")
 	end
 		
 end
 	
end
