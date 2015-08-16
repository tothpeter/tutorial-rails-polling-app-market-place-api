class OrderSerializer < ActiveModel::Serializer
  attributes :total

  has_many :products
end
