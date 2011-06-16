class User
  include Ripple::Document

  self.bucket_name = 'playriak/users'

  property :name, String

  one :product_list

  before_create :create_lists

  def worshipped_product_keys
    mr = Riak::MapReduce.new(Ripple.client)
    k = self.key
    mr.filter(Worship.bucket) do
      starts_with "#{k}-"
    end
    mr.link(:bucket => Product.bucket_name)
    mr.map("function(v) { return [v['key']]; }", :keep => true)
    mr.run
  end

  private

  def create_lists
    self.product_list = ProductList.create!
  end
end
