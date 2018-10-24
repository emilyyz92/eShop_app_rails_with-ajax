class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_number
  has_many :orders
end
