class SubsController < ApplicationController
  before_action :ensure_signed_in, except: [:index, :show]
  before_action :check_if_moderator, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.modded_subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts.order(created_at: :desc)
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def check_if_moderator
    sub = Sub.find(params[:id])
    redirect_to sub_url(sub) unless sub.is_moderator?(current_user)
  end
end
