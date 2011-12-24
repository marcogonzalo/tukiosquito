class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string  :nombre, :limit=>100, :null=>false
      t.string  :apellido, :limit=>100, :null=>false
      t.string  :sexo, :limit=>1, :null=>false, :default=>'M'
      t.date    :fecha_nacimiento
      t.string  :correo_electronico, :limit=>100, :null=>false
      t.string  :usuario, :limit=>50, :null=>false
      t.string  :clave, :limit=>50, :null=>false
      t.string  :telefono, :limit=>25
      t.string  :direccion, :null=>false
      t.string  :ciudad, :limit=>50, :null=>false
      t.string  :estado, :limit=>20, :null=>false
      t.string  :pais, :limit=>50, :null=>false
      t.timestamps
    end
  end
end
