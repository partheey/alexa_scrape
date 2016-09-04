class WebsitesController < ApplicationController
  before_action :authenticate_user!

  def index
    @website = Website.new
    @websites = website_scope
  end

  def show
    @website = website_scope.find(params[:id])
    rank_logs = @website.rank_logs.pluck(:new_value, :created_at)
    @data = build_data_for_chart(rank_logs)
  end

  def create
    rank =  FetchRank.new.get(params[:address])
    if rank
      @website = current_user.websites.create(address: params[:address], rank: rank.to_i)
      redirect_to websites_path
    else
      flash[:danger] = 'Website not found in alexa !'
      render 'index'
    end
  end

  def destroy
    website_scope.find(params[:id]).destroy
    redirect_to websites_path
  end

  private
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
