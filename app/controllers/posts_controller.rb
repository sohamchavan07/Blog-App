class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:user, :tags).with_attached_cover_image.with_rich_text_body.order(created_at: :desc)

    unless user_signed_in? && current_user.admin?
      @posts = @posts.published.or(Post.where(user: current_user))
    end

    if params[:query].present?
      query = params[:query]
      if query.start_with?("#")
        tag_name = query[1..-1]
        @posts = @posts.joins(:tags).where(tags: { name: tag_name })
      else
        @posts = @posts.where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%")
      end
    end

    @pagy, @posts = pagy(@posts)
    fresh_when @posts, public: true if @posts.any? && params[:query].blank? && !user_signed_in?
  end

  def show
    @post.increment!(:views_count, touch: false)
    fresh_when @post, public: true
  end

  def new
    @post = current_user.posts.new
  end

  def edit
    redirect_to posts_path, alert: "Not authorized" unless can_manage_post?
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      ProcessImageJob.perform_later(@post.id) if post_params[:cover_image].present?
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if can_manage_post?
      if @post.update(post_params)
        ProcessImageJob.perform_later(@post.id) if post_params[:cover_image].present?
        redirect_to @post, notice: "Post was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to posts_path, alert: "Not authorized"
    end
  end

  def destroy
    if can_manage_post?
      @post.destroy
      redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other
    else
      redirect_to posts_path, alert: "Not authorized"
    end
  end

  private

  def set_post
    @post = Post.includes(:user, :tags, comments: :user).with_attached_cover_image.with_rich_text_body.friendly.find(params[:id])
  end

  def can_manage_post?
    user_signed_in? && (current_user == @post.user || current_user.admin?)
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag_list, :cover_image, :status)
  end
end
