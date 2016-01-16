Rails.application.routes.draw do

  get 'about/company_overview'

  devise_for :user, controllers: { 
  sessions: "users/sessions", 
  registrations: "users/registrations", 
  passwords: "users/passwords",
  omniauth_callbacks: "users/omniauth_callbacks" 
  }
  resources :users, only: [:index, :show, :edit, :update]
  root to: "top#index" 
  resources :blogs
  get 'contacts' => 'contacts#index'              # 入力画面
  post 'contacts' => 'contacts#index'              # 入力画面
  post 'contacts/confirm' => 'contacts#confirm'   # 確認画面
  post 'contacts/thanks' => 'contacts#thanks'     # 送信完了画面
  get 'contacts/inbox' => 'contacts#inbox'
  
end
