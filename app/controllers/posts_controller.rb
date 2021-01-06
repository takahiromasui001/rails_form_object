class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @form = PostForm.new
  end

  def create
    @form = PostForm.new(post_params)

    if @form.save
      redirect_to posts_path, notice: 'The post has been created'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :tag_names)
  end
end
