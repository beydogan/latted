Sociality::Application.routes.draw do


  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :attachments


  resources :item_categories


  resources :item_catalogs


  devise_for :users
  root :to => "home#index"

  get "home/index"

  resources :items


  get 'items/:id/action/:act' => 'items#action', :as => "item_action"
end
