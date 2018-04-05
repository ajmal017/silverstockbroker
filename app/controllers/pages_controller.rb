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

  def search_results
    @posts = Post.all
    @term = params[:search]

    @commentary = Post.tagged_with(@term).where(:category => 'commentary').order("created_at DESC") rescue nil
    @news = Post.tagged_with(@term).where(:category => 'news').order("created_at DESC") rescue nil
    @backtests = Post.tagged_with(@term).where(:category => 'backtest').order("created_at DESC") rescue nil
    @author = Post.where(:author => @term).order("created_at DESC") rescue nil
  end
end
