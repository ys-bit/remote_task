class TaskController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_corrent_user, {only: [:edit, :update, :destroy]}

  #タスク一覧ページ
  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  #タスク詳細ページ
  def show
    @task = Task.find_by(id: params[:id])
    @user = @task.user
  end

  #新規タスク作成ページ
  def new
    @task = Task.new
  end

  #新規タスク作成ボタン
  def create
    @task = Task.new(
      content: params[:content],
      user_id: @current_user.id
    )
    if @task.save
      flash[:notice] = "タスクを作成しました"
      redirect_to("/task/index")
    else
      render("task/new")
    end
  end

  #タスク編集ページ
  def edit
    @task = Task.find_by(id: params[:id])
  end

  #タスクの変更ボタン
  def update
    @task = Task.find_by(id: params[:id])
    @task.content = params[:content]
    @task.save
    redirect_to("/task/index")
  end

  #タスクの削除ボタン
  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to("/task/index")
  end

  #ログインユーザーのアクセス権限
  def ensure_corrent_user
    @task = Task.find_by(id: params[:id])
    if @task.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/task/index")
    end
  end
end
