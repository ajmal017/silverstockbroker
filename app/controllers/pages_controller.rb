class PagesController < ApplicationController
  def index
    @commentaries = Post.where(:category => 'commentary').order("created_at DESC")
    @news = Post.where(:category => 'news').order("created_at DESC")
  end

  def news
    @posts = Post.where(:category => 'news').order("created_at DESC")
  end

  def commentary
    @posts = Post.where(:category => 'commentary').order("created_at DESC")
  end

  def backtests
    @posts = Post.where(:category => 'backtest').order("created_at DESC")
  end
end
