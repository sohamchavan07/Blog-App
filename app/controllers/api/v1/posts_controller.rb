module Api
  module V1
    class PostsController < ApplicationController
      # authorize_request is already called in ApplicationController for JSON requests
      before_action :set_post, only: [ :show, :update, :destroy ]

      def index
        @posts = Post.includes(:user, :comments, :tags).order(created_at: :desc)
        render json: @posts
      end

      def show
        render json: @post
      end

      def create
        @post = @current_user.posts.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy
        head :no_content
      end

      private

      def set_post
        @post = Post.includes(:user, :comments, :tags).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Post not found" }, status: :not_found
      end

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end
