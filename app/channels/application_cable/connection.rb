module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      reject_unauthorized_connection unless find_verified_user
    end

    private

    #Websocket側で使うためのcurrent_user情報を取得
    def find_verified_user
      self.current_user = User.find_by(id: cookies.signed["user.id"])
    end
  end
end
