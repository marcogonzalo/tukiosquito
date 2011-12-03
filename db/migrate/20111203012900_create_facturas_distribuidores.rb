class CreateFacturasDistribuidores < ActiveRecord::Migration
  def change
    create_table :facturas_distribuidores do |t|

      t.timestamps
    end
  end
end
