class TimeEntry < ApplicationRecord
  
  after_create :check_time_entry_card_count
  after_destroy :set_total_hours_to_nil

  belongs_to :time_card

  def check_time_entry_card_count
    time_card = self.time_card
    if time_card.present? && time_card.entries.count == 2
      calculate_total_hours(time_card)
    end
  end

  def calculate_total_hours
    total_hours = ((time_card.entries.second.time - time_card.entries.first.time) / 1.hour).round(2)
    time_card.update!(total_hours: total_hours)
  end

  def set_total_hours_to_nil
    time_card = self.time_card
    if time_card.present? && time_card.total_hours.present?
      time_card.update(total_hours: nil)
    end
  end

end
