Fugue::Application.routes.draw do
  resources :pieces, :only => [:index, :show]
  root :to => 'pieces#index'
end
