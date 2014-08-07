class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @comment.parent_comment_id = params[:parent_comment_id]
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.top_level_comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end

end
