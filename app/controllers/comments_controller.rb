class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  after_action :sending_pusher, only: [:create]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(recipient_id: @blog.user_id, sender_id: current_user.id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@comment.blog_id), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        @blog = @comment.blog
        @comments = @blog.comments
        format.js { render :index, notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to blog_path(@comment.blog_id), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blogs_path(@comment.blog), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      @blog = @comment.blog
      @comments = @blog.comments
      format.js { render :index, notice: '削除しました。' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:blog_id, :user_id, :content)
    end

    def sending_pusher
      Notification.sending_pusher(@notification.recipient_id)
    end
end
