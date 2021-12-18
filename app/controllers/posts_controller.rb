class PostsController < ApplicationController
before_action :set_post, only: %i[update]
before_action :current_session_user, {only: [:create, :index, :search, :update, :destroy, :import]}
skip_before_action :verify_authenticity_token

  def create
    @post = Post.new(post_params)
    if @post.save
        @posts_same_type = Post.where(question_type: @post.question_type)
        if @posts_same_type != nil
          @post.update(question_id: @posts_same_type.count)
        else
          @post.update(question_id: 1)
        end
    end
    redirect_to posts_path
    @posts = Post.all
  end

  def index
      @posts = Post.all.order(created_at: :desc)
      @post = Post.new
      respond_to do |format|
        format.html
        format.csv do
          products_csv
        end
      end
  end
  def search
    @posts = Post.search(params[:keyword]).where(question_type: params[:question_type]).order(created_at: :desc)
    @keyword = params[:keyword]
    @question_type = params[:question_type]
    render "index"
  end

  def update
    if @post.update!(post_update_params)
      render json: @post
    else
      head :bad_request # ①ステータスコードを400番で返す
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post_id = @post.id
    @msg = "削除が成功"
    @post.destroy
  end

  def post_update_params
  params.require(:post)
        .permit(:answer, :question)
  end

  def import
    if params[:file] != nil
      Post.import(params[:file])
      redirect_to posts_path
      flash[:success] = 'csvインポート成功'
    else
      flash[:alert] = 'csvをインポートできませんでした'
      redirect_to posts_path
    end
  end

  def download_csv
  send_file(
    "#{Rails.root}/public/faq_template.csv",
    filename: "faq_template.csv",
    type: "application/csv"
  )
  end

  private

  def products_csv
    csv_date = CSV.generate do |csv|
    csv_column_names = ["ID","Type", "Title", "Question","Answer"]
    csv << csv_column_names
    @posts.each do |post|
      csv_column_values = [
        post.question_id,
        post.question_type,
        post.title,
        post.question,
        post.answer,
      ]
      csv << csv_column_values
      end
    end
      send_data(csv_date,filename: "faq.csv")
    end
    def set_post
      @post = Post.find(params[:id])
    end
    def post_params
      params.permit(:title, :question, :answer, :question_id, :question_type)
    end
end
