class DashboardController < ApplicationController
  before_action  :authenticate_user!

  def index
  end

  def all_posts
    @posts = Post.all
  end

  def posts
    @postNew = Post.new
  end

  def dash_commentary_posts
    @posts = Post.where(:category => 'commentary')
  end

  def dash_news_posts
    @posts = Post.where(:category => 'news')
  end

  def dash_backtest_posts
    @posts = Post.where(:category => 'backtest')
  end

  def symbols
    @stockNew = Stock.new
    @stocks = Stock.all
  end
end
