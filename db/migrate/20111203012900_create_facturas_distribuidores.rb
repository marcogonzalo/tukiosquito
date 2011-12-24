class CreateFacturasDistribuidores < ActiveRecord::Migration
  def change
    create_table :facturas_distribuidores do |t|
      t.integer :orden_id, :null=>false
      t.string  :distribuidor, :limit=>100, :null=>false
      t.string  :numero_orden, :limit=>20, :null=>false
      t.float   :total, :null=>false
      t.date    :fecha_entrega, :null=>false
      t.timestamps
    end
  end
end
