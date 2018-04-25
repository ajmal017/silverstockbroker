class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def new
    @post = Post.new
  end

  def slug
    name.downcase.gsub(" ", "-")
  end

  def show
    @post = Post.find_by!(:slug => params[:slug])
    render template: "post/post/#{params[:id]}"
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to dashboard_all_posts_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find_by!(:slug => params[:slug])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_all_posts_path, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find_by slug: params[:slug]
  end

  def post_params
    params.require(:post).permit(:title, :content, :category, :author, :all_tags)
  end

end
