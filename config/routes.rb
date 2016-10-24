Rails.application.routes.draw do
  
  root 'pages#home'
  get 'pages/home'



  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :stores
  resources :articles


   # Custom routes for Rest services.


    get 'services/stores', :to => 'stores#services_index'
    get 'services/articles', :to => 'articles#services_index'
    get 'services/articles/stores/:id', :to => 'stores#services_articles_by_store'



 
end
