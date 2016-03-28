class Taskline::TasksController < ApplicationController

  def ungoodjob
  end

  def goodjob
    # 該当のタスクへの自分がグッジョブした件数をカウント
    gdcount = Goodjob.where(task_id: goodjob_params[:task_id], user_id: current_user.id).count
    if gdcount == 0
      # 過去に自分がグッジョブしていなければそのまま新規登録
      @gjb = Goodjob.create(user_id: current_user.id, task_id: goodjob_params[:task_id], number: 1)
    else
      @gjb = Goodjob.find_by(user_id: current_user.id, task_id: goodjob_params[:task_id])
      # 過去に自分がグッジョブしていればカウントアップして追加登録
      @gjb.number = @gjb.number + 1
      @gjb.update(user_id: current_user.id)
    end
    @gjb_all_cnt = Goodjob.where(task_id: goodjob_params[:task_id]).sum(:number)
    # JavaScriptで画面表示を変更
    respond_to do |format|
      format.js
    end
  end

  def index
    #自分とフォロー相手のタスクを表示
    @feed_tasks = current_user.taskfeed.page(params[:page])
    #タスクにコメントするためのモデルオブジェクト生成
    @taskcomment = TaskComment.new
    #タスクにグッドジョブするためのモデルオブジェクト生成
    @goodjob = Goodjob.new
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :user_id, :charge_id, :deadline, :done, :status)
  end

  def task_comment_params
    params.require(:comment).permit(:user_id, :task_id, :content)
  end

  def goodjob_params
    params.require(:goodjob).permit(:user_id, :task_id, :number)
  end

end
