Rails.application.routes.draw do
  #新規ユーザー作成
  post 'user/create' => 'user#create'
  #新規ユーザー作成ページ
  get 'signup' => 'user#new'
  #ユーザー一覧ページ
  get 'user/index' => 'user#index'
  #ユーザー詳細ページ
  get 'user/:id' => 'user#show'
  #ユーザー編集ページ
  get 'user/:id/edit' => 'user#edit'
  #ユーザー情報更新
  post 'user/:id/update' => 'user#update'
  #ユーザー削除
  post 'user/:id/destroy' => 'user#destroy'
  #ログインページ
  get 'login' => 'user#login_form'
  #ログインボタン
  post 'login' => 'user#login'
  #ログアウトボタン
  post 'logout' => 'user#logout'

  #タスク一覧ページ
  get 'task/index' => 'task#index'
  #タスク新規作成ページ
  get 'task/new' => 'task#new'
  #タスク新規作成
  post 'task/create' => 'task#create'
  #タスク詳細ページ
  get 'task/:id' => 'task#show'
  #タスク編集ページ
  get 'task/:id/edit' => 'task#edit'
  #タスク情報更新
  post 'task/:id/update' => 'task#update'
  #タスク削除
  post 'task/:id/destroy' => 'task#destroy'
  #トップページ
  get '/' => 'home#top'
  #アプリ紹介ページ
  get '/about' => 'home#about'

  #チャットルーム一覧ページ
  get 'rooms/index' => 'rooms#index'
  #チャットルームページ
  get 'rooms/:id' => 'rooms#show'
  #チャットルームのコメント一括削除
  post 'rooms/:id/destroy' => 'rooms#destroy'
  #roomの新規作成
  post 'rooms/index' => 'rooms#create'
  #roomの削除
  post 'rooms/index/destroy_room' => 'rooms#destroy_room'
end
