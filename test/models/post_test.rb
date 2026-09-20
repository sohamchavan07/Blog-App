require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
  end

  test "reading_time returns 1 for empty body" do
    assert_equal 1, @post.reading_time
  end

  test "reading_time returns 1 for short body" do
    @post.body = ActionText::RichText.new(body: "hello world")
    assert_equal 1, @post.reading_time
  end

  test "reading_time returns 3 for 401 words" do
    words = "word " * 401
    @post.body = ActionText::RichText.new(body: words)
    assert_equal 3, @post.reading_time
  end

  test "summary returns empty string when both body and legacy_body are blank" do
    assert_equal "", @post.summary
  end

  test "summary returns plain text from body when present" do
    @post.body = ActionText::RichText.new(body: "<p>Hello <b>world</b></p>")
    assert_equal "Hello world", @post.summary
  end

  test "plain_text_summary returns empty string when body is blank" do
    assert_equal "", @post.plain_text_summary
  end

  test "plain_text_summary strips HTML from body" do
    @post.body = ActionText::RichText.new(body: "<p>Plain <b>text</b></p>")
    assert_equal "Plain text", @post.plain_text_summary
  end

  test "tag_list returns joined tag names" do
    assert_equal "TagOne", @post.tag_list
  end

  test "tag_list= creates tags from comma-separated names" do
    @post.tag_list = "ruby, rails"
    @post.save!(validate: false)
    assert_equal 2, @post.tags.count
    tag_names = @post.tags.pluck(:name)
    assert_includes tag_names, "ruby"
    assert_includes tag_names, "rails"
  end

  test "tag_list= strips whitespace from names" do
    @post.tag_list = "  ruby  , rails "
    @post.save!(validate: false)
    tag_names = @post.tags.pluck(:name)
    assert_includes tag_names, "ruby"
    assert_includes tag_names, "rails"
  end

  test "tag_list= reuses existing tags" do
    Tag.create(name: "existing")
    @post.tag_list = "existing, new"
    @post.save!(validate: false)
    assert_equal 1, Tag.where(name: "existing").count
    assert_equal 2, @post.tags.count
  end

  test "tag_list= replaces existing tags" do
    @post.tag_list = "ruby"
    @post.tag_list = "rails"
    @post.save!(validate: false)
    assert_equal 1, @post.tags.count
    assert_includes @post.tags.pluck(:name), "rails"
  end

  test "set_defaults sets views_count to 0 on new record" do
    new_post = Post.new
    assert_equal 0, new_post.views_count
  end

  test "validates title presence" do
    new_post = Post.new(title: nil)
    refute new_post.valid?
    assert new_post.errors[:title].any?
  end

  test "validates title length" do
    new_post = Post.new(title: "a" * 201)
    refute new_post.valid?
    assert new_post.errors[:title].any?
  end

  test "validates body presence" do
    new_post = Post.new(title: "Title", body: nil)
    refute new_post.valid?
    assert new_post.errors[:body].any?
  end
end
