Rails.application.routes.draw do

devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
get 'restaurants' => 'restaurants#index'

root to: "restaurants#index"


resources :restaurants, shallow: true do
  resources :reviews do
    resources :endorsements
  end
end

end
