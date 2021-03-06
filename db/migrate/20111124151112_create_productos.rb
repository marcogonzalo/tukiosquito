class CreateProductos < ActiveRecord::Migration
  def change
    #, :options => "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
    create_table :productos do |t|
      t.string  :nombre, :limit => 100, :null => false
      t.string  :descripcion, :null => false
      t.integer :categoria_id, :limit => 3, :null => false
      t.integer :subcategoria_id, :limit => 3
      t.float   :precio, :null => false
      t.integer :cantidad, :limit => 5, :null => false
      t.float   :peso, :limit => 2, :null => false
      t.integer :alto, :limit => 5
      t.integer :ancho, :limit => 5
      t.integer :largo, :limit => 5
      t.string :imagen, :default=>"productos/imgprod.png"
      t.boolean :resaltar, :default=>false 
      t.date    :fecha_fin_venta
      t.timestamps
    end
  end
end
