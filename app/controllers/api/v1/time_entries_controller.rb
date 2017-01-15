class Api::V1::TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :update, :destroy]

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
    @time_entry = TimeEntry.new(time_entry_params)

    if @time_entry.save
      check_time_entry_card_count(time_entry)
      render json: @time_entry, status: :created, location: @time_entry
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/time_entries/1
  def update
    if @time_entry.update(time_entry_params)
      check_time_entry_card_count(time_entry)
      render json: @time_entry
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/time_entries/1
  def destroy
    if @time_entry.present?
      @time_entry.destroy 
      set_total_hours_to_nil(time_entry)
      head :ok
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  private
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    def time_entry_params
      params.require(:time_entry).permit(:time, :time_card_id)
    end

    def check_time_entry_card_count(time_entry)
      time_card = time_entry.time_card
      if time_card.present? && time_card.entries.count == 2
        calculate_total_hours(time_card)
      end
    end

    def calculate_total_hours(time_card)
      total_hours = ((time_card.entries.second.time - time_card.entries.first.time) / 1.hour).round(2)
      time_card.update!(total_hours: total_hours)
    end

    def set_total_hours_to_nil(time_entry)
      time_card = time_entry.time_card
      if time_card.present? && time_card.total_hours.present?
        time_card.update(total_hours: nil)
      end
    end

end
