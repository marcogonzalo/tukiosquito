class Administrador < ActiveRecord::Base
  TIPO_ADMIN = ["global","productos","usuarios"]
  validates :nombre,
            :length => 3..50
  validates :apellido,
            :length => 3..50
  validates :correo_electronico, 
            :presence => true,
            :length => 5..100
  validates :usuario, 
            :presence => true,
            :length => 5..50
  validates :clave, 
            :presence => true,
            :length => 8..50
  validates :tipo,
            :length => 5..20, 
            :inclusion => { :in => TIPO_ADMIN.map {|tipo| tipo} }
end
