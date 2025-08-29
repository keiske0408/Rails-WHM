Rails.application.routes.draw do
  
  # devise_for :users
  # root 'dashboard#index'

  # # Dashboard
  # get 'dashboard', to: 'dashboard#index'

  # # Goods Receipt
  # resources :goods_receipts do
  #   collection do
  #     get :search_items
  #     get :search_po
  #   end
  #   member do
  #     patch :submit_to_sap
  #   end
  # end

  # # Withdrawal Requests
  # resources :withdrawal_requests do
  #   collection do
  #     get :pending_approvals
  #     get :my_requests
  #     get :search_gr_items
  #   end
  #   member do
  #     patch :approve
  #     patch :reject
  #   end
  # end

  # # Goods Issuance
  # resources :goods_issuances do
  #   member do
  #     patch :issue_to_sap
  #     get :barcode_scan
  #   end
  # end

  # # Inventory Reports
  # resources :inventory_reports, only: [:index] do
  #   collection do
  #     get :export_csv
  #     get :export_pdf
  #   end
  # end

  # # Business Units
  # resources :business_units, only: [:index, :show]

  # # Admin routes
  # namespace :admin do
  #   resources :users
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  # # API endpoints
  # namespace :api do
  #   namespace :v1 do
  #     resources :items, only: [:index, :show]
  #     resources :inventory_levels, only: [:index]
  #   end
  # end

  
  # Real-time updates
  mount ActionCable.server => '/cable'
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

end