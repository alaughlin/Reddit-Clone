class PostsController < ApplicationController
  before_action :ensure_signed_in
  before_action :verify_author_id, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @sub = Sub.find(params[:sub_id])
    @post = @sub.posts.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def index
    @posts = Sub.find(params[:sub_id]).posts
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to sub_url(@post.sub)
  end

  def show
    @post = Post.find(params[:id])
    #@comments = @post.comments
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def verify_author_id
    @post = Post.find(params[:id])
    redirect_to post_url(@post) unless @post.user == current_user
  end
end
