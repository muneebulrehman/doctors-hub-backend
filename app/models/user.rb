class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 6, maximum: 20 }
  validates :email, presence: true, length: {maximum: 60}
end
