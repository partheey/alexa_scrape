class WebsitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_website, only: [:show, :destroy, :get_rank_logs_with_date]
  before_action :common_get, only: [:show,:get_rank_logs_with_date]
  def index
    @website = Website.new
    @websites = website_scope
  end

  def show
  end

  def create
    rank, error =  FetchRank.new.get(params[:address])
    if rank
      @website = current_user.websites.create(address: params[:address], rank: rank)
      redirect_to websites_path
    else
      redirect_to websites_path
      flash[:danger] = error
    end
  end

  def destroy
    @website.destroy
    redirect_to websites_path
  end

  def get_rank_logs_with_date
    render json: { rank_logs: @data }, status: :ok
  end

  private
  def common_get
    rank_logs = @website.rank_logs.pluck(:new_value, :created_at)
    @data = build_data_for_chart(rank_logs)
  end
  def set_website
    @website = website_scope.find(params[:id])
  end

  def website_scope
    current_user.websites
  end

  def build_data_for_chart(param)
    param.map{ |param| {'date' => build_date(param[1]), 'value' => param[0]} }
  end

  def build_date(date)
    { 'year' => date.year, 'month' => date.month, 'day' => date.day }
  end
end
