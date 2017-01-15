class Api::V1::TimeCardsController < ApplicationController
  before_action :set_time_card, only: [:show, :update, :destroy]

  # GET /time_cards
  def index
    @time_cards = TimeCard.all

    render json: @time_cards, include: :time_entries
  end

  # GET /time_cards/1
  def show
    render json: @time_card, include: :time_entries
  end

  # POST /time_cards
  def create
    @time_card = TimeCard.new(time_card_params)

    if @time_card.save
      render json: @time_card, status: :created
    else
      render json: @time_card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /time_cards/1
  def update
    if @time_card.update(time_card_params)
      render json: @time_card
    else
      render json: @time_card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /time_cards/1
  def destroy
    @time_card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_card
      @time_card = TimeCard.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_card_params
      params.require(:time_card).permit(:username, :occurrence)
    end
end
