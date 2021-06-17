Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home', to: 'home#index'
  root to: 'home#index'
  
  post '/quiz', to: 'questions#index'

  get '/questions', to: 'questions#question'

  post '/submit', to: 'questions#submit'

  get '/endgame', to: 'questions#endgame'
end
