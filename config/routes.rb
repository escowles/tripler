Rails.application.routes.draw do
  resources :vocabs do
    resources :predicates
  end
  root "vocabs#index"
end
