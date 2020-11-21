class RoomsController < ApplicationController
before_action :authenticate_user

  #チャットルーム一覧ページ
  def index
    @rooms = Room.all.order(:id)
  end

  #チャットルーム
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  #チャットルーツのコメント一括削除ボタン
  def destroy
    @messages = Message.all
    @messages.each do |message|
      message.destroy
    end
    redirect_to("/rooms/#{params[:id]}")
  end

  #チャットルーム削除ボタン
  def create
    @room = Room.new(name: params[:name])
    if @room.save
      redirect_to("/rooms/index")
    elsif @room.name == ""
      @rooms = Room.all.order(:id)
      @error_message = ""
      render("rooms/index")
    else
      @rooms = Room.all.order(:id)
      @error_message = "#{params[:name]}はすでに存在します。別の名前を入力してください。"
      render("rooms/index")
    end
  end

  #チャットルーム削除ボタン
  def destroy_room
    @room = Room.find_by(name: params[:name])
    if @room
      @room.destroy
      redirect_to("/rooms/index")
    end
  end
end
