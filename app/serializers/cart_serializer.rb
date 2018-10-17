class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :products
  has_many :products

  def products
    object.uniq_product
  end
end
