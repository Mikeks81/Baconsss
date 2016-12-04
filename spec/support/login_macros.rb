module LoginMacros
	def set_user_session(user)
		session[:user_id] = user.id
	end

	# def sign_in(user)
	# 	#refactor details to be accurate to this app
	# 	visit root_path
	# 	click_link 'Log In'
	# 	fill_in 'Email', with: user.email
	# 	fill_in 'Password', with: user.password
	# 	click_button 'Log In'
 # 	end
end