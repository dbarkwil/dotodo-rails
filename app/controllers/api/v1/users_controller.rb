module Api
	module V1
		class UsersController < ApplicationController
			before_filter :require_http_auth_user, :only => :login

			respond_to :json

			def login
				@user = current_user
				respond_with @user.single_access_token
			end

			private

			def require_http_auth_user
				authenticate_or_request_with_http_basic do |username, password|
					if user = User.find_by_username(username)
						user.valid_password?(password)
					else
						false
					end
				end
			end

		end
	end
end
