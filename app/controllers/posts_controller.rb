class PostsController < ApplicationController
  def show
    if params[:id].present?
      @swagger = Post.find(params[:id])
    else
      # Handle the case where no ID is provided
      # For example, you might want to redirect to the index page
      redirect_to posts_path, notice: "1"
    end
  end # This 'end' closes the 'show' action block

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  def create
    @post = Post.new(params[:post].permit(:title, :content))
    if @post.save
      redirect_to posts_path
    end
  end

end
