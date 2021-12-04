class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    if @post.save
        @posts_same_type = Post.where(question_type: @post.question_type)
        if @posts_same_type != nil
          @post.question_id = @posts_same_type.count + 1
        else
          @post.question_id = 1
        end
    end
    redirect_to posts_path
    @posts = Post.all
  end

  def index
      @posts = Post.all
      @post = Post.new
  end
  def search
    @posts = Post.search(params[:keyword]).where(question_type: params[:question_type])
    @keyword = params[:keyword]
    @question_type =  params[:question_type]
    render "index"
  end

  private
    def post_params
      params.require(:post).permit(:question, :answer, :question_id, :question_type)
    end
end
