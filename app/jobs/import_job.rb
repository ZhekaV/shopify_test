class ImportJob < ApplicationJob
  queue_as :import

  def perform(shop_id)
    ImportProducts.call(shop_id)
  end
end
