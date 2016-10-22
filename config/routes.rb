Rails.application.routes.draw do
  

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :stores
  resources :articles


   # Custom routes for Rest services.
  scope '/services' do
    get '/stores', :to => 'stores#rest_index'
    get '/articles', :to => 'articles#rest_index'
     get '/articles/stores/:id', :to => 'stores#rest_articles_by_store'
  end

 
end
