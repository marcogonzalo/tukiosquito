class CreateSelecciones < ActiveRecord::Migration
  def change
    create_table :selecciones do |t|
      t.integer :cliente_id
      t.integer :producto_id
      t.integer :cantidad

      t.timestamps
    end
  end
end
