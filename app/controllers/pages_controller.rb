class PagesController < ApplicationController
  def index
    @commentaries = Post.where(:category => 'commentary')
    @news = Post.where(:category => 'news')
  end

  def news
    @posts = Post.where(:category => 'news')
  end

  def commentary
    @posts = Post.where(:category => 'commentary')
  end

  def backtests
    @posts = Post.where(:category => 'backtest')
  end
end
