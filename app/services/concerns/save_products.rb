module SaveProducts
  extend ActiveSupport::Concern

  def save_products
    products.each do |product|
      @current_product = product
      @persisted_product = Product.find_by(shopify_id: current_product.id)

      next if persisted_product && persisted_product.updated_at > current_product.updated_at

      init_temp_product
      assign_variants
      save_product
    end
  end

  private

  attr_reader :current_product, :persisted_product, :temp_product

  def init_temp_product
    @temp_product = Product.new(
      current_product.attributes.slice(:title, :body_html, :product_type, :published_scope).merge(
        shop:               shop,
        shopify_id:         current_product.id,
        shopify_created_at: current_product.created_at,
        shopify_updated_at: current_product.updated_at,
        image_url:          current_product.image.src,
        url:                'url'
      )
    )
  end

  def assign_variants
    current_product.variants.each do |variant|
      temp_product.variants << Variant.new(
        variant.attributes.slice(:title, :sku, :position).merge(
          shopify_id:         variant.id,
          shopify_created_at: variant.created_at,
          shopify_updated_at: variant.updated_at,
          price:              (variant.price.to_f * 100).to_i,
          image_url:          variants_with_images[variant.id],
          url:                'url'
        )
      )
    end
  end

  # TODO: refactor & memoise it
  def variants_with_images
    temp = current_product.images.map { |i| [i.variant_ids, i.src] unless i.variant_ids.blank? }.compact
    return {} if temp.blank?
    hash = {}
    temp.each do |im|
      im[0].each do |id|
        hash[id] = im[1]
      end
    end
    hash
  end

  def save_product
    persisted_product.delete if persisted_product.present?
    temp_product.save
  end
end
