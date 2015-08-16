class Order < ActiveRecord::Base
  before_validation :set_total!

  belongs_to :user

  has_many :placements
  has_many :products, through: :placements

  validates :user_id, presence: true

  def set_total!
    self.total = products.map(&:price).sum
  end
end
