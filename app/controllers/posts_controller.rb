class PostsController < ApplicationController
  before_action :authorized?, except: :index

  def index
  	@posts = Post.all.order("created_at DESC")
  end

  def show
  	@post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
    @post.user = current_user

  	if @post.save
      flash[:notice] = "Post successfully created."
      redirect_to posts_path
  	else 
      flash.now[:error] = "title and body cannot be blank."
  		render :new
  	end
  end

  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      flash[:notice] = "Post successfully updated."
      redirect_to posts_path
    else 
      flash.now[:error] = "title and body cannot be blank."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    
    @post.destroy
    flash[:notice] = "Post successfully deleted."
    redirect_to posts_path
  end

  private
  def post_params
  	params.require(:post).permit(:title, :body, :image)
  end



end