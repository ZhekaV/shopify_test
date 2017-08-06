class ExportProducts
  prepend SimpleCommand

  def initialize(shop_id)
    @shop = Shop.find shop_id
  end

  def call
  end
end
