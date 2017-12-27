class ExchangeDatum < ApplicationRecord
  scope :days_between, ->(date_range) { where('date >= ? AND date <= ?', date_range[0], date_range[1]) }

  validates :date, uniqueness: true
  validates :date, :coef, presence: true

  class << self
    def convert(amount)
      select("id, date, coef, coef * #{amount.to_f} as converted_currency")
    end
  end
end
