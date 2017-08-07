class ProductsController < ShopifyController
  def export
    ExportJob.perform_later(current_shop.id)
    redirect_to root_path
  end

  def import
    ImportJob.perform_later(current_shop.id)
    redirect_to root_path
  end

  def xml
    @products = current_shop.products.includes(:variants, :collections).page(params[:page])
  end
end
