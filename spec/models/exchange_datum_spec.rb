RSpec.describe ExchangeDatum, type: :model do
  describe 'Validations test' do
    subject(:record) { create(:exchange_datum) }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:coef) }
    it { is_expected.to validate_uniqueness_of(:date) }
  end

  describe 'Class methods tests' do
    let(:size) { 10 }
    let(:amount) { 2 }
    let(:create_records_list) { create_list(:exchange_datum, size) }
    let(:days_between) { ExchangeDatum.days_between([20.years.ago, Date.current]) }
    let(:convert) { days_between.convert(amount) }

    before { create_records_list }

    it { expect(days_between.size).to eq(size) }

    context '.convert(amount)' do
      subject(:converted_elem) { convert.first }

      let(:exchange_datum) { days_between.find(converted_elem.id) }

      it { expect(converted_elem).to respond_to(:id) }
      it { expect(converted_elem).to respond_to(:date) }
      it { expect(converted_elem).to respond_to(:coef) }
      it { expect(converted_elem).to respond_to(:converted_currency) }

      it { expect(converted_elem.converted_currency).to eq(exchange_datum.coef * amount) }
    end
  end
end
