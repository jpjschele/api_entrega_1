class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :gid
      t.string :sku
      t.float :cost
      t.integer :group
      t.boolean :despachado
      t.float :price
      t.string :direccion
      t.string :oc_id
      t.date :vencimiento
      t.references :warehouse, foreign_key: true

      t.timestamps
    end
  end
end
