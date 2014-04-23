module Api
	module V1
		class CategoriesController < ApplicationController
			before_filter :restrict_access
			respond_to :json

			def index
        
        		duplicate_categories = category_params[:ids]
        
        		respond_with @user.categories.all.where.not(id: duplicate_categories).order("id ASC")
        
      		end

		    private
		    	def category_params
		    		params.permit(:format, {ids: []}, :token)
		    	end

		    	def restrict_access
		    		@user = User.find_by_single_access_token(category_params[:token])
		    		head :unauthorized unless @user
		    	end

		end
	end
end
