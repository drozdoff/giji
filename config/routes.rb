Rails.application.routes.draw do
  resources :pull_requests, only: [] do
    post :process_data, on: :collection
  end
end
