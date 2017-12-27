# rubocop:disable Metrics/BlockLength
RSpec.describe DataFetchService, type: :service do
  describe 'Class methods tests' do
    subject(:call_method) { described_class.call }

    after do |example|
      call_method unless example.metadata[:skip_after]
    end

    context '.call' do
      it 'responds with .csv_get' do
        expect(described_class).to receive(:csv_get)
      end

      it 'responds with .save_to_db' do
        expect(described_class).to receive(:save_to_db)
      end
    end

    context '.csv_get' do
      it 'responds with IO.copy_stream' do
        expect(IO).to receive(:copy_stream)
      end
    end

    context '.save_to_db' do
      let(:rows_count) { File.open(Rails.root.join('spec', 'fixtures', 'currency_data.csv')).readlines.size - 1 }

      it { expect(ExchangeDatum).to receive(:bulk_insert_in_batches) }

      it 'Check created rows count', skip_after: true do
        expect { call_method }.to change { ExchangeDatum.count } .by(rows_count)
      end

      it { expect(CSV).to receive(:foreach) }

      it { expect(described_class).to receive(:parsed_data).and_return([]) }
    end
  end
end
