class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:user, :tags).order(created_at: :desc)

    if params[:query].present?
      query = params[:query]
      if query.start_with?("#")
        tag_name = query[1..-1]
        @posts = @posts.joins(:tags).where(tags: { name: tag_name })
      else
        @posts = @posts.where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%")
      end
    end
  end

  def show
  end

  def new
    @post = current_user.posts.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other
  end

  private

  def set_post
    @post = Post.includes(:user, :comments).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end
end
