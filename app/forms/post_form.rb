class PostForm
  attr_reader :title, :content, :tag_names

  def initialize(params: nil, post: Post.new)
    @post = post
    @title = post.name
    @content = post.content
    @tag_names = post.tags.map(&:name).join(',')

    return if params.nil?

    @title = params[:title]
    @content = params[:content]
    @tag_names = params[:tag_names]
  end

  def save
    ActiveRecord::Base.transaction do
      tags = @tag_names.split(',').map { |tag| Tag.find_or_create_by(name: tag) }
      @post.update!(name: @title, content: @content, tags: tags)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    @post
  end

  def persisted?
    @post.persisted?
  end
end
