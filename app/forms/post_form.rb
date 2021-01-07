class PostForm
  include ActiveModel::Model

  attr_accessor :title, :content, :tag_names

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    ActiveRecord::Base.transaction do
      tags = tag_names.split(',').map { |name| Tag.find_or_create_by!(name: name) }
      post.update!(name: title, content: content, tags: tags)
    end
  rescue ActiveRecord::RecordInvalid
    false
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
