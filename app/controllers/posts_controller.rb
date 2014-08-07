class PostsController < ApplicationController
  before_action :ensure_signed_in
  before_action :verify_author_id, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.sub_ids = post_params[:sub_ids]

    if @post.save
      redirect_to full_show_url(@post)
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
    @subs = @post.subs
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to full_show_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @sub = Sub.find(params[:sub_id])
    #@comments = @post.comments
  end

  def full_show
    @post = Post.find(params[:id])
    @subs = @post.subs
    #@comments = @post.comments
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids => [])
  end

  def verify_author_id
    @post = Post.find(params[:id])
    redirect_to post_url(@post) unless @post.author == current_user
  end
end
