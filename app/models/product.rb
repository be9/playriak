class Product
  include Ripple::Document

  self.bucket_name = 'playriak/product'

  property :name, String
end
