Sociality::Application.routes.draw do


  resources :comments


  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :attachments


  resources :item_categories


  resources :item_catalogs


  devise_for :users
  root :to => "home#index"

  get "home/index"

  resources :items
  resources :users


  get 'items/:id/action/:act' => 'items#action', :as => "item_action"
  get 'users/:id/follow' => 'users#follow', :as => "follow_user"
  get 'users/:id/unfollow' => 'users#unfollow', :as => "unfollow_user"
end
