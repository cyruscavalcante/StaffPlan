StaffPlan::Application.routes.draw do
  
  get "sign_out" => "sessions#destroy", :as => "sign_out"
  get "sign_in" => "sessions#new", :as => "sign_in"

  post "versions/:id/revert" => "versions#revert", as: "revert_to"  
  
  resources :users do
    resources :projects, :only => [:update, :create, :destroy],
                         :controller => "users/projects" do
      resources :work_weeks, :only => [:show, :update, :create],
                             :controller => "users/projects/work_weeks"
    end
  end
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :clients
  resources :projects
  resources :staffplans, :only => [:show, :index]
  resources :companies, only: [:new, :create]  
  match '/my_staffplan' => "staffplans#my_staffplan", via: :get, as: "my_staffplan"
  
  root :to => 'staffplans#my_staffplan'
end
