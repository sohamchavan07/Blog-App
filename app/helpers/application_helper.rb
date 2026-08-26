module ApplicationHelper
  include Pagy::Frontend

  def title(text)
    content_for(:title) { text }
  end

  def meta_tag(name, content)
    content_for(:meta_tags) { tag.meta(name: name, content: content) }
  end

  def og_tag(property, content)
    content_for(:meta_tags) { tag.meta(property: "og:#{property}", content: content) }
  end

  def twitter_tag(name, content)
    content_for(:meta_tags) { tag.meta(name: "twitter:#{name}", content: content) }
  end

  def full_title(page_title = "")
    base_title = "BlogApp"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def main_container_class
    return "" if controller_name == "pages" && action_name == "home"
    return "container container--wide" if controller_name == "posts" && action_name == "index"

    "container"
  end
end
