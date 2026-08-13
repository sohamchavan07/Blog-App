module Services
  class PublishPost
    def initialize(post, actor: nil)
      @post = post
      @actor = actor
    end

    # Publishes a post and performs side-effects (notifications, analytics)
    def call
      ActiveRecord::Base.transaction do
        @post.update!(status: :published)

        # Example side-effect: notify author subscribers if mailer exists
        if defined?(PostMailer)
          PostMailer.with(post: @post).published_email.deliver_later
        end
      end

      @post
    end
  end
end
