class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @form = PostForm.new
  end

  def create
    @form = PostForm.new(params: post_params)

    if @form.save
      redirect_to posts_path, notice: 'The post has been created'
    else
      render :new
    end
  end

  def edit
    @form = PostForm.new(post: Post.find(params[:id]))
  end

  def update
    @form = PostForm.new(params: post_params, post: Post.find(params[:id]))

    if @form.save
      redirect_to posts_path, notice: 'The post has been updated'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :tag_names)
  end
end
