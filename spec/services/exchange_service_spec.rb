# rubocop:disable Metrics/BlockLength
RSpec.describe ExchangeService, type: :service do
  let(:amount) { 100 }
  let(:range) { "#{20.years.ago.strftime('%Y-%m-%d')} - #{Date.current.strftime('%Y-%m-%d')}" }
  let(:params) { { amount: amount, range: range } }
  let(:object) { ExchangeService.new(params) }

  describe 'responds with attrs' do
    subject(:obj) { object }

    it { expect(obj).to respond_to(:amount) }
    it { expect(obj).to respond_to(:range) }
  end

  describe '.call' do
    after { ExchangeService.call(params) }

    it { expect(described_class).to receive(:new).and_return(instance_double('ExchangeService', exchange: true)) }
    it { expect_any_instance_of(described_class).to receive(:exchange) }
  end

  describe '#date_range' do
    subject(:obj) { object.date_range }

    it { expect(obj.class).to be(Array) }
    it { expect(obj.size).to eq(2) }
  end

  describe '#exchange' do
    subject(:obj) { object.exchange }

    let(:size) { 10 }
    let(:create_records_list) { create_list(:exchange_datum, size) }

    before { create_records_list }

    after do |example|
      obj unless example.metadata[:skip_filter]
    end

    it { expect(ExchangeDatum).to receive_message_chain(:days_between, :convert) }
    it 'check size', skip_filter: true do
      expect(obj.size).to be(size)
    end
  end
end
