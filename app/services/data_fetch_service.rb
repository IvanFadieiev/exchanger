require 'open-uri'
require 'csv'

class DataFetchService
  class << self
    URL = 'http://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?format=csvdata'
    FILE_PATH = Rails.root.join('public', 'data', 'currency_data.csv')

    def call
      csv_get && save_to_db
    end

    private

    def csv_get
      download = open(URL)
      IO.copy_stream(download, FILE_PATH)
    end

    def save_to_db
      ExchangeDatum.bulk_insert_in_batches(parsed_data, validate: true, batch_size: 1000)
    end

    def parsed_data
      [].tap do |array|
        CSV.foreach(FILE_PATH, headers: true) do |row|
          array << { date: row['TIME_PERIOD'], coef: row['OBS_VALUE'] }
        end
      end
    end
  end
end
