class Worship
  include Ripple::Document

  self.bucket_name = 'playriak/worships'

  one :user
  one :product

  validates :user, :product, :presence => true

  before_create :set_key

  def self.for_user_and_product(user, product)
    find("#{user.key}-#{product.key}")
  end

  private

  def set_key
    self.key = "#{user.key}-#{product.key}"
  end
end
