Rails.application.routes.draw do
  devise_for :users, controllers: {
            registrations: "users/registrations",
          }

  scope module: "buyer" do
    get "dashboard", to: "dashboard#index", as: "buyer_dashboard"
    resource :profile, only: [:show, :edit, :update]
    resources :subscriptions, only: [:new, :create,:index] do
      member do
        post "cancel"
      end
    end

    get "usage_report", to: "usage#index"
    resources :transactions, only: [:index]
  end

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    
    resources :features
    resources :plans do
      resources :plan_features, only: [:create, :destroy]
    end
    

    resources :plan_features, only: [:create, :destroy]
    resources :usages, only: [:new, :create] do
      collection do
        get :features_for_buyer
      end
    end
    
    resource :profile, only: [:show, :edit, :update]

    get "buyers/:buyer_id/features", to: "usages#features_for_buyer", as: "buyer_features"
    post "billing/run", to: "billing#run", as: "run_billing"
  end
end
