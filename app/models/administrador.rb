class Administrador < ActiveRecord::Base
  require 'digest/md5'
  before_save :encriptar_clave
  
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

  def self.autenticar(usuario, clave)
    admin = find_by_usuario(usuario)
    if admin and admin.clave == Digest::MD5.hexdigest(clave)
      admin
    else
      nil
    end
  end  

  def encriptar_clave
    if clave.present?
      self.clave = Digest::MD5.hexdigest(clave)
    end
  end
end
