class CommentsController < ApplicationController

	def edit
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		redirect_to post_path(@post) unless @comment.user == current_user
	end

	def update
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		if @comment.user == current_user
			@comment.update_attributes(comment_params)
		end
		redirect_to post_path(@post)
	end

	def create
		comment = Comment.new(comment_params)
		post = Post.find(params[:post_id])
		comment.user = current_user
		comment.post = post

		if comment.save
			redirect_to post_path(post)
		else
			render :new
		end
	end

  def destroy
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

	if @comment.user == current_user
		@comment.destroy
		redirect_to post_path(@post)
	else
		redirect_to post_path
	end

  end	

	private
	def comment_params
		params.require(:comment).permit(:body)
	end


end
