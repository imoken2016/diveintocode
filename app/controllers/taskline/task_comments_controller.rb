class Taskline::TaskCommentsController < ApplicationController
  before_action :set_taskline_task_comment, only: [:show, :edit, :update, :destroy]

  # GET /taskline/task_comments
  # GET /taskline/task_comments.json
  def index
    @taskline_task_comments = TaskComment.all
  end

  # GET /taskline/task_comments/1
  # GET /taskline/task_comments/1.json
  def show
  end

  # GET /taskline/task_comments/new
  def new
    @taskline_task_comment = TaskComment.new
  end

  # GET /taskline/task_comments/1/edit
  def edit
  end

  # POST /taskline/task_comments
  # POST /taskline/task_comments.json
  def create
    @taskline_task_comment = TaskComment.new(taskline_task_comment_params)

    respond_to do |format|
      if @taskline_task_comment.save
        @task = @taskline_task_comment.task
        @feed_tasks = current_user.taskfeed
        format.js { render :index, notice: 'タスクの登録をしました。' }
      end
    end
  end

  # PATCH/PUT /taskline/task_comments/1
  # PATCH/PUT /taskline/task_comments/1.json
  def update
    respond_to do |format|
      if @taskline_task_comment.update(taskline_task_comment_params)
        format.html { redirect_to @taskline_task_comment, notice: 'Task comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @taskline_task_comment }
      else
        format.html { render :edit }
        format.json { render json: @taskline_task_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taskline/task_comments/1
  # DELETE /taskline/task_comments/1.json
  def destroy
    @taskline_task_comment.destroy
    respond_to do |format|
      format.html { redirect_to taskline_task_comments_url, notice: 'Task comment was successfully destroyed.' }
      format.json { head :no_content }
      @task = @taskline_task_comment.task
      format.js { render :index, notice: 'Task comment was successfully destroyed'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taskline_task_comment
      @taskline_task_comment = TaskComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def taskline_task_comment_params
      params.require(:task_comment).permit(:user_id, :task_id, :content)
    end
end
