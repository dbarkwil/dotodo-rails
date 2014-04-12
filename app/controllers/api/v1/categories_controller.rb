module Api
	module V1
		class CategoriesController < ApplicationController
			respond_to :json

			def index
        
        		duplicate_categories = category_params[:ids]
        
        		respond_with Category.all.where.not(id: duplicate_categories)
        
      		end

		    private
		    	def category_params
		    		params.permit(:format, {ids: []})
		    	end

		end
	end
end
