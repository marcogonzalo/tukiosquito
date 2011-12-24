class CreateAdministradores < ActiveRecord::Migration
  def change
    create_table :administradores do |t|
      t.string  :nombre, :limit=>50
      t.string  :apellido, :limit=>50
      t.string  :correo_electronico, :limit=>100, :null=>false
      t.string  :usuario, :limit=>50, :null=>false
      t.string  :clave, :limit=>50, :null=>false
      t.string  :tipo, :limit=>20
      t.timestamps
    end
  end
end
