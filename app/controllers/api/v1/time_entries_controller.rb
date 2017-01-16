class Api::V1::TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :update, :destroy]
  before_action :set_time_card,  only: :create

  # GET /api/v1/time_entries
  def index
    @time_entries = TimeEntry.all

    render json: @time_entries
  end

  # GET /api/v1/time_entries/1
  def show
    render json: @time_entry
  end

  # POST /api/v1/time_entries
  def create
    @time_entry = @time_card.time_entries.build(time_entry_params)

    if @time_entry.save
      render json: @time_entry, status: :created
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/time_entries/1
  def update
    if @time_entry.update(time_entry_params)
      render json: @time_entry
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/time_entries/1
  def destroy
    if @time_entry.present?
      @time_entry.destroy 
      head :ok
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  private
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    def set_time_card
      @time_card = TimeCard.find(params[:time_card_id])
    end

    def time_entry_params
      params.require(:time_entry).permit(:time, :time_card_id)
    end

end
