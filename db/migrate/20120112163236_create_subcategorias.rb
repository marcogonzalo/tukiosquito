class CreateSubcategorias < ActiveRecord::Migration
  def change
    create_table :subcategorias do |t|

      t.timestamps
    end
  end
end
