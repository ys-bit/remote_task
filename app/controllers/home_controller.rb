class HomeController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}

  #トップページ
  def top
  end

  #アプリ紹介ページ
  def about
  end
end
