class CreateSubcategorias < ActiveRecord::Migration
  def change
    create_table :subcategorias do |t|
      t.string  :nombre, :limit=>100, :null=>false
      t.string  :descripcion, :limit=>255
      t.integer :categoria_id, :limit => 3, :null => false
    end
  end
end
