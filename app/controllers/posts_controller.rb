class PostsController < ApplicationController

  http_basic_authenticate_with name: "erik", password: "kessler",
  except: [:index, :show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @khan_test = khan
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  def khan
    response = HTTParty.get("http://khanacademy.org/api/v1/exercises")
    response[0]["translated_short_display_name"]
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end

end
