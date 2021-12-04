class UsersController < ApplicationController
  def show
    @posts = Post.all
    @post = Post.new
  end
end
