module Api
	module V1
		class TasksController < TodoController
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

      		def create
      			@category = @user.categories.find_by(id: task_params[:catid])
      			if @category
      				@task = Task.new(:label => task_params[:label])
      				@task.category = @category
      				@task.due_date = task_params[:due_date] ? DateTime.strptime(task_params[:due_date].to_s, '%Y-%m-%d %I:%M:%S %p') : nil
      				if @task.save
      					respond_with @task.to_json(:only => :id)
      				else
      					null_response = {'error_code' => 0,'text' => 'Could not create task.'}
		    			respond_with null_response.to_json
      				end
      			else
      				null_response = {'error_code' => 1,'text' => 'Could not find category.'}
		    		respond_with null_response.to_json
      			end
      		end

			def complete
		        @task = @user.tasks.find_by(id: task_params[:id])

		        if @task
			        @task.completion_date = Time.zone.now
			        if @task.save
			          respond_with @task.to_json(:only => [:id, :completion_date])
			        else
			          respond_with @task.errors, status: :unprocessable_entity
			        end
			    else
			    	null_response = {'error_code' => 2,'text' => 'Task ID is incorrect.'}
		    		respond_with null_response.to_json
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
		    		params.permit(:format, {ids: []}, :catid, :label, :id, :due_date)
		    	end

		end
	end
end
