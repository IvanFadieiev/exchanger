class ExchangeService
  attr_accessor :amount, :range

  def initialize(params_data)
    @amount = params_data[:amount]
    @range = params_data[:range]
  end

  class << self
    def call(params)
      new(params).exchange
    end
  end

  def date_range
    range.split(' - ')
  end

  def exchange
    ExchangeDatum.days_between(date_range).convert(amount)
  end
end
