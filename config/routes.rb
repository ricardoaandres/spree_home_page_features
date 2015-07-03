Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :banners
    resources :banner_categories
  end
end
