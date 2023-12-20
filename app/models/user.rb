class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :username, type: String
  field :email, type: String
  field :password_digest, type: String
end
