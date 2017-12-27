# rubocop:disable Metrics/BlockLength
RSpec.describe ExchangeDataController, type: :controller do
  describe '#index' do
    subject(:request) { get :index }

    before do |example|
      request unless example.metadata[:skip_filter]
    end

    it { expect(response.status).to eq(200) }
    it { expect(assigns(:data)).to be_nil }
    it '', skip_filter: true do
      expect(request).to render_template(:index)
    end
  end

  describe '#fetch_data' do
    subject(:request) { get :fetch_data }

    before do |example|
      request unless example.metadata[:skip_filter]
    end

    it 'redirect to root', skip_filter: true do
      expect(request).to redirect_to(:root)
    end

    it 'call DataFetchService.call', skip_filter: true do
      expect(DataFetchService).to receive(:call)
      request
    end

    it { expect(flash[:notice]).to be_present }
    it 'return error', skip_filter: true do
      allow(DataFetchService).to receive(:call).and_raise(StandardError.new('error'))
      request
      expect(flash[:error]).to be_present
    end
  end

  describe '#data_selection' do
    subject(:request) { post :data_selection, params: params }

    let(:size) { 10 }
    let(:amount) { 100 }
    let(:range) { "#{20.years.ago.strftime('%Y-%m-%d')} - #{Date.current.strftime('%Y-%m-%d')}" }
    let(:params) { { amount: amount, range: range } }

    before do |example|
      create_list(:exchange_datum, size)
      request unless example.metadata[:skip_filter]
    end

    it 'render index', skip_filter: true do
      expect(request).to render_template(:index)
    end

    it { expect(assigns('amount')).to eq(amount.to_s) }
    it { expect(assigns('data')).to be_present }
    it { expect(assigns('data').size).to eq(10) }
  end
end
