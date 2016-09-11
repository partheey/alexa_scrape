class WebsitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_website, only: [:show, :destroy]
  before_action :website_scope
  def index
    @website = Website.new
  end

  def show
    data_for_graph
  end

  def create
    rank, error =  FetchRank.new.get(params[:address])
    if rank
      @website = current_user.websites.create(address: params[:address], rank: rank)
    else
      flash[:danger] = error
    end
    render :index
  end

  def destroy
    @website.destroy
    render :index
  end

  # def get_rank_logs_with_date
  #   render json: { rank_logs: @data }, status: :ok
  # end

  private
  def data_for_graph
    rank_logs = @website.rank_logs.pluck(:new_value, :created_at)
    @data = build_data_for_chart(rank_logs)
  end
  def set_website
    @website = website_scope.find(params[:id])
  end

  def website_scope
    @websites = current_user.websites
  end

  def build_data_for_chart(param)
    param.map{ |param| {'date' => build_date(param[1]), 'value' => param[0]} }
  end

  def build_date(date)
    { 'year' => date.year, 'month' => date.month, 'day' => date.day }
  end
end
