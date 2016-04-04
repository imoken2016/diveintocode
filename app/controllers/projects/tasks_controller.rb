class Projects::TasksController < ApplicationController
  before_action :task_params, only: [:create]
  before_action :set_project, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_update_permissible_attributes, only: [:update]

  PERMISSIBLE_ATTRIBUTES = %i(title content done)

  def new
    @task = Task.new
  end

  def create
    @task = @project.tasks.build(task_params)
    @task.user_id = current_user.id
    @task.charge_id = current_user.id

    if @task.save
      redirect_to project_path(@project), notice: "タスクを登録しました。"
    else
      render "new", notice: "タスク登録に失敗しました。"
    end
  end

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_url(@project), notice: 'タスクを編集しました' }
        format.json { render :show, status: :ok, location: @project }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_url(@project), notice: 'タスクを削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    #プロジェクトをセットする
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(PERMISSIBLE_ATTRIBUTES)
    end

    def set_update_permissible_attributes
      PERMISSIBLE_ATTRIBUTES << :status
    end
end
