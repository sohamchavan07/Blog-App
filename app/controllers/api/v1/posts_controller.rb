module Api
  module V1
    class PostsController < ApplicationController
      # authorize_request is already called in ApplicationController for JSON requests
      before_action :set_post, only: [ :show, :update, :destroy ]

      def index
        @posts = Post.order(created_at: :desc)

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

        # Include pagination info in headers
        pagy_headers_merge(@pagy)

        render json: {
          posts: @posts.as_json(only: [ :id, :title, :body, :created_at ]),
          pagination: {
            count: @pagy.count,
            page: @pagy.page,
            items: @pagy.items,
            pages: @pagy.pages,
            next: @pagy.next,
            prev: @pagy.prev
          }
        }
      end

      def show
        render json: @post.as_json(only: [ :id, :title, :body, :created_at ])
      end

      def create
        @post = @current_user.posts.new(post_params)
        if @post.save
          render json: @post.as_json(only: [ :id, :title, :body, :created_at ]), status: :created
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render json: @post.as_json(only: [ :id, :title, :body, :created_at ])
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
        @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Post not found" }, status: :not_found
      end

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end
