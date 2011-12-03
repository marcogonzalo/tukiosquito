class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos, :options => "ENGINE=InnoDB" do |t|
      t.string :nombre, :null => false
      t.string :descripcion, :null => false
      t.integer :categoria_id, :null => false
      t.integer :subcategoria_id
      t.float :precio
      t.integer :cantidad, :null => false
      t.float :peso
      t.integer :alto
      t.integer :ancho
      t.integer :largo
      t.date :fecha_fin_venta
      t.timestamps
    end
  end
end
