class WebsitesController < ApplicationController
  before_action :authenticate_user!

  def index
    @website = Website.new
    @websites = website_scope
  end

  def show
    @website = website_scope.find(params[:id]).includes(:rank_logs)
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
    data = []
    param.each do |p|
      # TO DO
    end
  end

end
