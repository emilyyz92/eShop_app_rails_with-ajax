class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :products, :total
  has_many :products

  def products
    object.uniq_product
  end

  def total
    object.total_price
  end
end
