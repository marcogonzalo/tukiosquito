class Cliente < ActiveRecord::Base
  has_many :tdc
  has_many :ordenes
  
  SEXO = ["M","F"]
  validates :nombre,
            :presence => true,
            :length => 5..100
  validates :apellido,
            :presence => true,
            :length => 5..100
  validates :sexo, 
            :presence => true,
            :inclusion => { :in => SEXO.map {|sexo| sexo} }
  validates :fecha_nacimiento,
            :length => 5..10
  validates :correo_electronico, 
            :presence => true,
            :length => 10..100
  validates :usuario, 
            :presence => true, 
            :uniqueness => true,
            :length => 5..50
  validates :clave, 
            :presence => true,
            :length => 8..50
  validates :telefono,
            :length => 10..25
  validates :direccion,
            :presence => true,
            :length => 10..255
  validates :ciudad,
            :presence => true,
            :length => 5..50
  validates :estado,
            :presence => true,
            :length => 5..20
  validates :pais,
            :presence => true,
            :length => 5..50
end
