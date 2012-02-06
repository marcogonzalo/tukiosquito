class CreateTdc < ActiveRecord::Migration
  def change
    create_table :tdc do |t|
      t.integer :cliente_id, :null=>false
      t.string  :numero, :limit=>20, :null=>false
      t.string  :tipo, :limit=>20, :null=>false, :default=>"Visa"
      t.string  :codigo, :limit=>3, :null=>false, :default=>"000"
      t.integer :mes_vencimiento, :limit=>2, :null=>false, :default=>12
      t.integer :ano_vencimiento, :limit=>2, :null=>false, :default=>12
      t.string  :direccion, :limit=>255, :null=>false
      t.string  :tarjetahabiente, :limit=>255, :null=>false
      t.timestamps
    end
  end
end
