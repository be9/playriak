class User
  include Ripple::Document

  self.bucket_name = 'playriak/user'

  property :name, String
end
