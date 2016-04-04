Rails.application.routes.draw do

  resources :project_members
  resources :projects do
    resources :tasks, controller: "projects/tasks"
  end

  namespace :taskline do
    resources :task_comments
  end
  namespace :taskline do
    resources :task_comments
  end
  resources :tasks
  get 'relationships/create'

  get 'relationships/destroy'

  resources :comments
  get 'about/company_overview'

  devise_for :user, controllers: { 
  sessions: "users/sessions", 
  registrations: "users/registrations", 
  passwords: "users/passwords",
  omniauth_callbacks: "users/omniauth_callbacks" 
  }
  resources :users, only: [:index, :show, :edit, :update] do
    resources :tasks
    member do
      get :following, :followers
    end
  end
  root to: "top#index"
  resources :blogs do
    resources :comments
  end
  namespace :taskline do
    resources :tasks do
      resources :task_comment
      post "goodjob"
      delete "ungoodjob"
    end
  end
  get 'contacts' => 'contacts#index'              # 入力画面
  post 'contacts' => 'contacts#index'              # 入力画面
  post 'contacts/confirm' => 'contacts#confirm'   # 確認画面
  post 'contacts/thanks' => 'contacts#thanks'     # 送信完了画面
  get 'contacts/inbox' => 'contacts#inbox'
  resources :relationships, only: [:create, :destroy]
  
end
