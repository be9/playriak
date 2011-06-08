class Worship
  include Ripple::Document

  property :user_id, String
  property :product_id, String

  one :user
  one :product

  def key
    @key ||= "#{user_id}_#{product_id}"
  end

  def self.for_user_and_product(user, product)
    find("#{user.id}_#{product.id}")
  end
end
