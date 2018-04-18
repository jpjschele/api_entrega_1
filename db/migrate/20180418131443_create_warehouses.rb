class CreateWarehouses < ActiveRecord::Migration[5.1]
  def change
    create_table :warehouses do |t|
      t.string :gid
      t.integer :usedSpace
      t.integer :totalSpace
      t.boolean :reception
      t.boolean :despacho
      t.boolean :pulmon
      t.integer :group

      t.timestamps
    end
  end
end
