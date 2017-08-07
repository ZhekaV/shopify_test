class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.integer :shop_id, null: false
      t.integer :shopify_id, null: false, limit: 8
      t.datetime :shopify_created_at
      t.datetime :shopify_updated_at
      t.string :kind, null: false
      t.string :handle
      t.string :title
      t.text :body_html
      t.string :sort_order
      t.string :template_suffix
      t.string :published_scope
      t.timestamps
    end
    add_index :collections, :shop_id
    add_index :collections, :published_scope
    add_index :collections, :shopify_id, unique: true
    add_foreign_key :collections, :shops, on_delete: :cascade
  end
end
