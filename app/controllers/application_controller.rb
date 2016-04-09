class ApplicationController < ActionController::API
	include ActionController::MimeResponds
  include ActionController::ImplicitRender

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
	end

	def doorkeeper_token
    methods = Doorkeeper.configuration.access_token_methods
    @token ||= OAuth::Token.authenticate request, *methods
	end
	
end
