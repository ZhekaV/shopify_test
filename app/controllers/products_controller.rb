class ProductsController < ShopifyController
  def export
    ExportJob.perform_later(current_shop.id)
    redirect_to root_path
  end

  def import
    ImportJob.perform_later(current_shop.id)
    redirect_to root_path
  end

  def xml; end
end
