module Api
	module V1
		class TasksController < ApplicationController
			respond_to :json

			def index
        
        		# # get a list of duplicate_items
        		duplicate_tasks = task_params[:ids]

        
        		# # get a list of all incomplete_items
        		# incomplete_items = Item.where(completed_at: nil)
        		if task_params[:catid] == nil
        			tasks = Task.all
        		else
        			tasks = Task.all.where(category: task_params[:catid])
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


		    private
		    	def task_params
		    		params.permit(:format, {ids: []}, :catid)
		    	end




		end
	end
end
