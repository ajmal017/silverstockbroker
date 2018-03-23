class DashboardController < ApplicationController
  before_action  :authenticate_user!

  def index
  end

  def all_posts
    @posts = Post.all.order("created_at desc")
  end

  def posts
    @postNew = Post.new
  end

  def dash_commentary_posts
    @posts = Post.where(:category => 'commentary').order("created_at DESC")
  end

  def dash_news_posts
    @posts = Post.where(:category => 'news').order("created_at DESC")
  end

  def dash_backtest_posts
    @posts = Post.where(:category => 'backtest').order("created_at DESC")
  end

  def symbols
    @stockNew = Stock.new
    @stocks = Stock.all
  end
end
