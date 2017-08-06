class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :shop_id, null: false
      t.integer :shopify_id, null: false
      t.string :title, null: false
      t.text :body_html
      t.string :product_type
      t.string :published_scope
      t.string :image_url
      t.string :url
      t.timestamps
    end
    add_index :products, :published_scope
    add_index :products, :shop_id
    add_foreign_key :products, :shops, on_delete: :cascade
  end
end
