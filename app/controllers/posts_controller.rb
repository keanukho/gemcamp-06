class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :validate_post_owner, only: [:edit, :update, :destroy]

  def show
    if params[:id].present?
      @swagger = Post.find(params[:id])
    else
      redirect_to posts_path, notice: "1"
    end
  end

  def index
    @posts = Post.includes(:categories, :user).all
    @posts = Post.includes(:categories).page(params[:page]).per(5)
    @posts = @posts.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @posts = @posts.where("content LIKE ?", "%#{params[:content]}%") if params[:content].present?

    if params[:start_date].present? && params[:end_date].present?
      start_date = DateTime.parse(params[:start_date])
      end_date = DateTime.parse(params[:end_date])
      @posts = @posts.where(created_at: start_date..end_date.end_of_day)
    end

    @posts = @posts.order(created_at: params[:order_by]) if params[:order_by].present?
  end

  def new
    @post = Post.new
  end

  def create
    # render json: params
    @post = Post.new(params[:post].permit(:title, :content, :image))
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, category_ids: [])
  end

  def validate_post_owner
    unless @post.user == current_user
      flash[:notice] = 'the post not belongs to you'
      redirect_to posts_path
    end
  end
end
