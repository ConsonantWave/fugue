Fugue::Application.routes.draw do
  resources :pieces, :only => [:index, :show, :edit, :update, :destroy]
  root :to => 'pieces#index'
end
