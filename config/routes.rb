Rails.application.routes.draw do
  get "/books/:id" => "books#show"
  delete "/books/:id" => "books#destroy"
  resources :publishers
  resource :profile, only: %i{show edit update} # indexと:idが存在しない

  # resources :publishers do
  #   resources :books
  #   member do
  #     get 'detail'
  #   end
  #   collection do
  #     get 'search'
  #   end
  # end
end
