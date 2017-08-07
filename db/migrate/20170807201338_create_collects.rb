class CreateCollects < ActiveRecord::Migration[5.1]
  def change
    create_table :collects do |t|
      t.belongs_to :shop, null: false
      t.integer :collection_shopify_id, null: false, limit: 8
      t.integer :product_shopify_id, null: false, limit: 8
      t.timestamps
    end
    add_index :collects, %i[collection_shopify_id product_shopify_id], unique: true
    add_foreign_key :collects, :shops, on_delete: :cascade

    change_column :collections, :shop_id, :bigint
    change_column :products, :shop_id, :bigint
    change_column :variants, :product_id, :bigint
  end
end
