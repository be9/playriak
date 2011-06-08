class Product
  include Ripple::Document

  self.bucket_name = 'playriak/products'

  property :name, String

  one :curator, class_name: 'User'
end
