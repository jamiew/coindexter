class WhitepapersController < ApplicationController
  before_action :set_whitepaper, only: [:show, :edit, :update, :destroy]

  def index
    if defined?(params[:network_id])
      @network = Network.friendly.find(params[:network_id])
      @whitepapers = @network.whitepapers
    else
      @whitepapers = Whitepaper.all
    end
  end

  def show
    @whitepaper = Whitepaper.friendly.find(params[:id]).whitepaper
  end

  def new
    if defined?(params[:network_id])
      @network = Network.friendly.find(params[:network_id])
      @whitepaper = @network.whitepapers.new
    else
      @whitepaper = @network.whitepapers.new
    end
  end

  def edit
  end

  def create
    @network = Network.friendly.find(params[:network_id])
    @whitepaper = Whitepaper.new(whitepaper_params)

    respond_to do |format|
      if @whitepaper.save
        @whitepaper.network = @network
        @whitepaper.save
        format.html { redirect_to network_whitepapers_path, notice: 'Whitepaper attachment was successfully created.' }
        format.json { render :show, status: :created, location: @whitepaper }
        puts "saved wp is #{@whitepaper.inspect}"
      else
        format.html { render :new }
        format.json { render json: @whitepaper.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @whitepaper.update(whitepaper_params)
        format.html { redirect_to @whitepaper.network, notice: 'Whitepaper was successfully updated.' }
        format.json { render :show, status: :ok, location: @whitepaper }
      else
        format.html { render :edit }
        format.json { render json: @whitepaper.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @whitepaper.destroy
    respond_to do |format|
      format.html { redirect_to whitepapers_url, notice: 'Whitepaper attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_whitepaper
      @whitepaper = Whitepaper.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def whitepaper_params
      params.require(:whitepaper).permit(:network, :network_id, :title, :whitepaper)
    end
end
