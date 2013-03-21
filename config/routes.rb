ThirtySevenSignalsCoversiteGenerator::Application.routes.draw do
  root :to => 'workflows#start'

  resource :workflow, path: '/', only: [] do
    get 'questions'
    get 'code'
    get 'lol'
    get 'github'
    post 'finish'
  end

  get '/:user', to: "user#show"
end
