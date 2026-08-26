module PostsHelper
  def author_display_name(user)
    user.full_name.presence || user.name.presence || user.email.split("@").first
  end

  def author_initials(user)
    name = author_display_name(user)
    parts = name.to_s.split(/\s+/)
    if parts.size >= 2
      "#{parts.first[0]}#{parts.last[0]}".upcase
    else
      name.to_s[0, 2].upcase
    end
  end

  def post_cover_tag(post, **options)
    return unless post.cover_image.attached?

    image_options = options.except(:link)
    if post.cover_image.variable? && post.cover_image.content_type != "image/svg+xml"
      image = image_tag post.cover_image.variant(resize_to_limit: [ 1200, 600 ]), **image_options
    else
      image = image_tag post.cover_image, **image_options
    end

    options[:link] ? link_to(post, class: "post-cover-link") { image } : image
  end

  def author_avatar_tag(user, size: :md)
    css_class = "author-avatar author-avatar--#{size}"
    if user.avatar.attached?
      variant = user.avatar.variable? ? user.avatar.variant(resize_to_limit: [ 100, 100 ]) : user.avatar
      image_tag variant, class: css_class, alt: author_display_name(user)
    elsif user.avatar_url.present?
      image_tag user.avatar_url, class: css_class, alt: author_display_name(user)
    else
      content_tag :span, author_initials(user), class: "#{css_class} author-avatar--initials"
    end
  end
end
