Sherlock::Application.routes.draw do
  use_doorkeeper
  mount API::Root => '/'
  mount Resque::Server.new, :at => "/resque"

  get 'welcome/index'
  root 'welcome#index'

  get 'auth/:provider/callback', to: 'authentications#create'
  get 'signout', to: 'authentications#destroy', as: 'signout'

end
