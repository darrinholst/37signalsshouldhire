ThirtySevenSignalsCoversiteGenerator::Application.routes.draw do
  root :to => 'workflows#start'

  resource :workflow, path: '/', only: [] do
    get 'questions'
    get 'code'
    get 'lol'
    get 'github', as: 'github'
  end
end
