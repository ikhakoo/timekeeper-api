class TimeCard < ApplicationRecord
	has_many :time_entries
	validates :username, presence: true
	validates :occurrence, presence: true
end
