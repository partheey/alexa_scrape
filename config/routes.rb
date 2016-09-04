Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :websites, only: [:index, :create, :show, :destroy] do
    member do
      get 'rank_logs' => 'websites#get_rank_logs_with_date'
    end
  end

  root 'websites#index'
end
