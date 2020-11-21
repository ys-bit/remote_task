class User < ApplicationRecord
has_secure_password

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}

  def tasks
    return Task.where(user_id: self.id)
  end

  has_many :messages
end
