module Api
	module V1
		class TodoController < ApplicationController

			before_filter :restrict_access
			respond_to :json



			private

		    	def restrict_access
		    		@user = User.find_by_single_access_token(params[:token])
		    		head :unauthorized unless @user
		    	end

		end
	end
end
