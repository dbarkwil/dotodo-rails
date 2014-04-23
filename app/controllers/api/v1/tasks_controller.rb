module Api
	module V1
		class TasksController < ApplicationController
			before_filter :restrict_access
			respond_to :json

			def index
        
        		# # get a list of duplicate_items
        		duplicate_tasks = task_params[:ids]

        
        		# # get a list of all incomplete_items
        		# incomplete_items = Item.where(completed_at: nil)
        		if task_params[:catid] == nil
        			tasks = @user.tasks.all.order("id ASC")
        		else
        			tasks = @user.tasks.all.where(category: task_params[:catid]).order("id ASC")
        		end
        		# #respond with all incomplete items that are NOT in duplicate_items array
        		respond_with tasks.all.where.not(id: duplicate_tasks)
        
      		end

			def complete
        
		        @task = Task.find(params[:id])
		        @task.completion_date = Time.zone.now
		        
		        if @task.save
		          respond_with @task
		        else
		          respond_with @task.errors, status: :unprocessable_entity
		        end
		    end

		    def show
		    	respond_with @user.tasks.all.where(id: params[:id])
		    end

		    def category_filter
		    	duplicate_tasks = task_params[:ids]

        		respond_with @user.tasks.all.where(category: params[:catid]).where.not(id: duplicate_tasks).order("id ASC")
		    end



		    private
		    	def task_params
		    		params.permit(:format, {ids: []}, :catid, :token)
		    	end

		    	def restrict_access
		    		@user = User.find_by_single_access_token(task_params[:token])
		    		head :unauthorized unless @user
		    	end

		end
	end
end
