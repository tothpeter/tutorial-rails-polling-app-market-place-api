class ProductSerializer < ActiveModel::Serializer
  cache key: 'products', expires_in: 3.hours

  attributes :title, :price, :published

  has_one :user
end
