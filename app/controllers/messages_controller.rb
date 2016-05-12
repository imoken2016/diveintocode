class MessagesController < ApplicationController
  before_action :set_conversation_params

  def index
    @messages = @conversation.messages.page(params[:page]).per(10).order(updated_at: :asc)
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end
    @message = @conversation.messages.build
    @conversation.read(current_user)
  end

  def new
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)

    if @message.save
      Pusher['notifications' + @message.conversation.recipient_id.to_s].trigger('message',{messaging: "メッセージが届いています。 :#{@message.body}"})
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end

    def set_conversation_params
      @conversation = Conversation.find(params[:conversation_id])
    end

end
