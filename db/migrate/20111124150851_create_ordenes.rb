class CreateOrdenes < ActiveRecord::Migration
  def change
    create_table :ordenes do |t|
      t.integer :usuario_id, :null=>false
      t.integer :tarjeta_id, :null=>false
      t.string  :direccion_entrega, :null=false
      t.float :total, :null=>false, :default=>0
      t.date :fecha_entrega
      t.timestamps
    end
  end
end
