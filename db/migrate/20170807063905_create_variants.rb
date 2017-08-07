class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants do |t|
      t.integer :product_id, null: false
      t.integer :shopify_id, null: false, limit: 8
      t.string :title, null: false
      t.integer :price, null: false
      t.string :sku
      t.integer :position
      t.string :image_url
      t.string :url
      t.datetime :shopify_created_at
      t.datetime :shopify_updated_at
      t.timestamps
    end
    add_index :variants, :product_id
    add_index :variants, :shopify_id, unique: true
    add_foreign_key :variants, :products, on_delete: :cascade
  end
end
