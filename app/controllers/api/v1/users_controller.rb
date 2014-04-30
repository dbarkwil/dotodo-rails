module Api
	module V1
		class UsersController < ApplicationController
			before_filter :require_http_auth_user, :only => :login

			respond_to :json

			def login
				@user = current_user
				respond_with @user.to_json(:only => :single_access_token)
			end

			def validate_token
				@user = User.find_by_single_access_token(params[:token])
		    	if @user
		    		respond_with @user.to_json(:only => :id)
		    	else
		    		null_response = {'id' => 0}
		    		respond_with null_response.to_json
		    	end
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

				def user_params
		    		params.permit(:token)
		    	end

		end
	end
end
