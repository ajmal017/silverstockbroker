class TagsController < ApplicationController
  def show
    arr = []
    Post.tagged_with(params[:id]).each do |tag|
      arr << tag.id
    end

    @posts = Post.find(arr);
    @title = params[:id]

    render template: "pages/tags/#{params[:title]}"
  end
end
