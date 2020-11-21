class UserController < ApplicationController
before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
before_action :ensure_correct_user, {only: [:edit, :update]}

  #ユーザー一覧ページ
  def index
    @users = User.all
  end

  #ユーザー詳細ページ
  def show
    @users = User.find_by(id: params[:id])
  end

  #ユーザー新規作成ページ
  def new
    @user = User.new
  end

  #ユーザー新規作成ボタン
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.png",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/user/#{@user.id}")
    else
      render("user/new")
    end
  end

  #ユーザー編集ページ
  def edit
    @user = User.find_by(id: params[:id])
  end

  #ユーザー情報更新ボタン
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/user/#{@user.id}")
    else
      render("user/edit")
    end
  end

  #ユーザー削除ボタン
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    @user.tasks.each do |task|
      task.destroy
    end
    redirect_to("/login")
  end

  #ログインページ
  def login_form
  end

  #ログインボタン
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      cookies.signed["user.id"] = session[:user_id]
      flash[:notice] = "ログインしました"
      redirect_to("/task/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています。"
      @email = params[:email]
      @password = params[:password]
      render("user/login_form")
    end
  end

  #ログアウトボタン
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  #ログインユーザーのアクセス権限
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/task/index")
    end
  end
end
