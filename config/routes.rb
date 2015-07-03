Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :banners
  end
end
