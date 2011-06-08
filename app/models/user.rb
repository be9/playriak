class User
  include Ripple::Document

  self.bucket_name = 'playriak/users'

  property :name, String

  def product_keys
    mr = Riak::MapReduce.new(Ripple.client)
    k = self.key
    mr.filter(Worship.bucket) do
      starts_with "#{k}-"
    end
    mr.link(:bucket => Product.bucket_name)
    mr.map("function(v) { return [v['key']]; }", :keep => true)
    mr.run
  end
end
