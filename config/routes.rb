Rails.application.routes.draw do
  resources :vocabs do
    resources :predicates
    resources :objs
  end
  resources :subjects do
    resources :statements
  end
  root "vocabs#index"
end
