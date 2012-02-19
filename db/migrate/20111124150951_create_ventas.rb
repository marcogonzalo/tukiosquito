class CreateVentas < ActiveRecord::Migration
  def change
    create_table :ventas do |t|
      t.integer :producto_id, :null=>false
      t.integer :orden_id, :null=>false
      t.integer :categoria_id, :null=>false
      t.integer :cantidad, :null=>false, :default=>1
      t.float   :costo, :null=>false
      t.timestamps
    end
  end
end
