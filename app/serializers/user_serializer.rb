class UserSerializer < ActiveModel::Serializer
  attributes :email

  has_many :products
end
