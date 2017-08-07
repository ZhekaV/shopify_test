class AddHandleToProducts < ActiveRecord::Migration[5.1]
  def change
    Product.delete_all
    add_column :products, :handle, :string, null: false
    add_column :products, :vendor, :string
  end
end
