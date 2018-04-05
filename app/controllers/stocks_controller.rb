class StocksController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  # GET /commentaries
  # GET /commentaries.json
  def index
    @stocks = Stocks.all
  end

  # GET /commentaries/1
  # GET /commentaries/1.json
  def show
    @symbol = params[:id].downcase
    @news = Post.tagged_with(@symbol).where(:category => 'news') rescue nil
    @commentary = Post.tagged_with(@symbol).where(:category => 'commentary') rescue nil
    @backtests = Post.tagged_with(@symbol).where(:category => 'backtest') rescue nil

    render template: "pages/stock/#{params[:name]}"
  end

  # GET /commentaries/new
  def new
    @stocks = Stock.new
  end
  #
  # # GET /commentaries/1/edit
  # def edit
  # end
  #
  # # POST /commentaries
  # # POST /commentaries.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to dashboard_symbols_path , notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end
  #
  # # PATCH/PUT /commentaries/1
  # # PATCH/PUT /commentaries/1.json
  # def update
  #   respond_to do |format|
  #     if @commentary.update(commentary_params)
  #       format.html { redirect_to @commentary, notice: 'Commentary was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @commentary }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @commentary.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /commentaries/1
  # # DELETE /commentaries/1.json
  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_symbols_path, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  #
  private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_stock
    #   @stock = Stock.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:name)
    end
end
