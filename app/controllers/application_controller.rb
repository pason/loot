class ApplicationController < ActionController::API
	include ExceptionHandler
	include Response
	include Knock::Authenticable
end
