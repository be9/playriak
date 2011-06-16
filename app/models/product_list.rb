class ProductList
  include Ripple::Document

  property :ids, Array, default: []

  def products(options = {})
    range = page_range(options[:page])
    records = Product.find(*self.ids[range]) || []
    PaginatedCollection.new records, options[:page], ids.size
  end

  def add_product(product)
    ids.unshift product.key unless ids.include?(product.key)
  end

  def remove_product(product)
    ids.delete(product.key)
    save
  end

  private

  def page_range(page, per_page = 20)
    skip = ((page || 1).to_i - 1) * per_page
    skip..skip + per_page - 1
  end

  class PaginatedCollection
    PER_PAGE = 20

    def initialize(elements, page, size)
      @elements = elements
      @page = (page || 1).to_i
      @size = size
    end

    def next_page
      @page + 1 if @page * PER_PAGE + 1 <= @size
    end

    def previous_page
      @page - 1 if @page > 1
    end

    delegate :==, :[], :each, :empty?, :any?, :size, :first, to: :elements

    private
    attr_reader :elements
  end
end
