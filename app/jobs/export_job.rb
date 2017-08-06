class ExportJob < ApplicationJob
  queue_as :export

  def perform(shop_id)
    ExportProducts.call(shop_id)
  end
end
