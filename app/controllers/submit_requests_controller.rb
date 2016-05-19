class SubmitRequestsController < ApplicationController
  before_action :set_submit_request, only: [:show, :edit, :update, :destroy]
  before_action :set_submit_request_approve, only: [:approve, :unapprove]
  after_action :sending_pusher, only: [:create]


  def index
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order("updated_at DESC")
  end

  def show

  end

  def new
    users_ids = current_user.mutual_followers.ids
    users_ids.delete(current_user.id)

    # つながっているユーザー
    @users = User.where(id: users_ids)
    # 自分が作成したタスク
    @tasks = Task.where(user_id: current_user.id, done: false).where.not(id: SubmitRequest.select(:task_id))
    # リクエスト新規作成用
    @submit_request = current_user.submit_requests.build(status: 1)
    @user = @submit_request.user
  end

  def create

    @submit_request = current_user.submit_requests.build(submit_request_params)
    @notification = @submit_request.notifications.build(sender_id: current_user.id, recipient_id: @submit_request.charge_id, read: false)

    respond_to do |format|
      if @submit_request.save
        @submit_request.task.update(status: 1)

        format.html { redirect_to @submit_request, notice: 'タスクを依頼しました。' }
      else
        format.html { render :new }
        format.json { render json: @submit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    # つながっているユーザー
    @users = User.where(id: current_user.mutual_followers.ids)
    @tasks = Task.where.not(id: SubmitRequest.select(:task_id)).where(user_id: current_user.id, done: false)
  end

  def update
    respond_to do |format|
      if @submit_request.update(submit_request_params)
        @submit_request.task.update(charge_id: submit_request_params[:charge_id])

        format.html { redirect_to @submit_request, notice: 'Successfully updated.' }
        format.json { render :show, status: :ok, location: @submit_request }
      else
        format.html { render :edit }
        format.json { render json: @submit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @submit_request.destroy
    respond_to do |format|
      format.html { redirect_to user_submit_requests_path(current_user), notice: '削除しました。' }
      format.json { head :no_content }
    end
  end


  def approve
    @submit_request.update(status: 2)
    @submit_request.task.update(status: 2)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order("updated_at DESC")
    respond_to do |format|
      format.js
    end
  end

  def unapprove
    @submit_request.update(status: 9)
    @submit_request.task.update(status: 9, charge_id: @submit_request.user_id)
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order("updated_at DESC")
    respond_to do |format|
      format.js
    end
  end

  def reject
    @submit_request = SubmitRequest.find(params[:submit_request_id])
    @submit_request.update(status: 8)
    @submit_request.task.update(status: 8, charge_id: current_user.id)
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order("updated_at DESC")
    respond_to do |format|
      format.js
    end
  end

  def approve_finish
  end

  def progress
  end

  def inbox
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order("updated_at DESC")
  end

  private
    def set_submit_request
      @submit_request = SubmitRequest.find(params[:id])
    end

    def set_submit_request_approve
      @submit_request = SubmitRequest.find(params[:submit_request_id])
    end

    def submit_request_params
      params.require(:submit_request).permit(:task_id, :user_id, :charge_id, :status, :message)
    end

    def sending_pusher
      Notification.sending_pusher(@notification.recipient_id)
    end
end
