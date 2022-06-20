class Admin::PostCosmesController < ApplicationController
  def index
    @post_cosmes = PostCosme.all
  end

  def show
    @post_cosme = PostCosme.find(params[:id])
    @customer = current_customer
    @comment = Comment.new
    @tags = Tag.all
  end

  def destroy
    @post_cosme = PostCosme.find(params[:id])
    @post_cosme.destroy
    redirect_to admin_post_cosmes_path
  end
end