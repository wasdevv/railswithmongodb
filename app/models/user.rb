class User
  include Mongoid::Document
  include Mongoid::Timestamps


  field :username, type: String
  field :email, type: String
  field :password_digest, type: String

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true, length: { minimum:4, maximum: 30 }, on: :addUser
end
