class ExchangeDataController < ApplicationController
  def index; end

  def fetch_data
    DataFetchService.call
    flash[:notice] = 'Data successfully parsed!'
  rescue => e
    flash[:error] = "Something went wrong! #{e}"
  ensure
    redirect_to :root
  end

  def data_selection
    @amount = permited_params[:amount]
    @data = ExchangeService.call(permited_params)
    render :index
  end

  private

  def permited_params
    params.permit(:amount, :range)
  end
end
