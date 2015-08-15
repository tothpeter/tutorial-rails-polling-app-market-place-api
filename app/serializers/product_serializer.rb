class ProductSerializer < ActiveModel::Serializer
  attributes :title, :price, :published
end
