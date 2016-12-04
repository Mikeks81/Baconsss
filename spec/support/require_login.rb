RSpec::Matchers.define :require_login do |expected|
	match do |actual|
		expect(actual).to redirect_to \
			# may have to change the the path name
			Rails.application.routes.url_helpers.login_path
	end	

	failure_message do |actual|
		"expected to require login to access method"
	end

	failure_message_when_negated do |actual|
		"expected not to require login to access method"
	end

	description do 
		"redirect to login form"
	end
end	