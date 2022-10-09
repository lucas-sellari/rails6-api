Rails.application.routes.draw do
  # get 'books/index' #created by rails scaffolding
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "/books" => "books#index" #controller#endpoint
  # resources :books #generate 7 RESTful resources

  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :create, :destroy]
    end
  end

end
