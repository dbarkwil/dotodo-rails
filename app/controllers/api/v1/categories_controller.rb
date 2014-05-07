module Api
	module V1
		class CategoriesController < TodoController
			respond_to :json

			def index
        
        		duplicate_categories = category_params[:ids]
        
        		respond_with @user.categories.all.where.not(id: duplicate_categories).order("id ASC")
        
      		end

      		def create
      			@category = Category.new(:label => category_params[:label])
      			@category.user = @user

      			
      			if @category.save
      				respond_with @category.to_json(:only => :id)
      			else
      				null_response = {'error_code' => 0,'text' => 'Could not create category.'}
		    		respond_with null_response.to_json
       			end
      			
      		end

		    private
		    	def category_params
		    		params.permit(:format, {ids: []}, :label)
		    	end

		end
	end
end
