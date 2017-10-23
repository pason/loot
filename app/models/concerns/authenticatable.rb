module Authenticatable
  extend ActiveSupport::Concern

  module ClassMethods
    #Find the entity by username when creating the token (when signing in)
    def from_token_request(request)
      username = request.params["auth"] && request.params["auth"]["username"]
      self.find_by(username: username)
    end
  end
end