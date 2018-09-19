class CommentsController < ApplicationController
  def new

    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    debugger
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
