class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :products, :total, :product_with_units
  has_many :products

  def products
    object.uniq_product
  end

  def total
    object.total_price
  end

  def product_with_units
    result = {}
    object.uniq_product.each do |product|
      result[product.name] = object.item_product_count(product)
    end
    return result
  end
end
