class PostsController < ApplicationController

  before_action :is_author?, only: [:edit, :update]

  def new
    @post = Post.new
    @subs = Sub.all

  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    # @post = Post.new(post_params)
    # @post.author = current_user
    # @sub_ids = Sub.find(params[:sub_id])
    # @post.sub = @sub
    @subs = Sub.all

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
  end

  def update
    @subs = Sub.all
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
  end

  private

  def is_author?
    current_user.id == Post.find(params[:id]).author_id
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :user_id, sub_ids: [])
  end
end
