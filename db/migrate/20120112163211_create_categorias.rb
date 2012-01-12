class CreateCategorias < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string  :nombre, :limit=>100, :null=>false
      t.string  :descripcion, :limit=>255
    end
  end
end
