class PostForm
  include ActiveModel::Model

  attr_accessor :title, :content, :tag_names

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end

  private

  attr_reader :post

  def default_attributes
    {
      title: post.name,
      content: post.content,
      tag_names: post.tags.pluck(:name).join(',')
    }
  end
end
