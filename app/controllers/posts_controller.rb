class PostsController < ApplicationController
  before_action :authorized?, except: :index

  def index
  	@posts = Post.all
  end

  def show
  	@post = Post.find(params[:id])
  end

  def new
  	@post = Post.new
  end

  def create
  	post = Post.new(post_params)
    post.user = current_user

  	if post.save
  		redirect_to posts_path
  	else 
  		render :new
  	end
  end

  private
  def post_params
  	params.require(:post).permit(:title, :body, :image)
  end



end