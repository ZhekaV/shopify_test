xml.instruct!
xml.root do
  xml.title 'Shop products'

  xml.items do
    @products.each do |product|
      variant = product.variants.first
      collections = product.collections

      xml.item do
        xml.sku variant.sku
        xml.product product.title
        xml.description product.body_html
        xml.image_url product.image_url

        first_category = collections[0]
        xml.first_category first_category.title, url_value: "collections/#{first_category.handle}/products/#{product.handle}"
        second_category = collections[1]
        xml.second_category second_category.title, url_value: "collections/#{second_category.handle}/products/#{product.handle}" unless second_category.blank?

        xml.brand product.vendor, url_value: "collections/#{first_category.handle}/products/#{product.handle}"
        xml.price variant.price
      end
    end
  end
end
