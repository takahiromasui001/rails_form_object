class PostForm
  def initialize(params = nil)
    return if params.nil?

    @name = params[:title]
    @content = params[:content]
    @tag_names = params[:tag_names]
  end

  def save
    ActiveRecord::Base.transaction do
      tags = @tag_names.split(',').map { |tag| Tag.find_or_create_by(name: tag) }
      Post.create!(name: @name, content: @content, tags: tags)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    Post.new
  end
end
