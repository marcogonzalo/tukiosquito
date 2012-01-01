class Orden < ActiveRecord::Base
  validates :usuario_id,
            :numericality => true,
            :presence => true
  validates :tarjeta_id,
            :numericality => true,
            :presence => true
  validates :direccion_entrega,
            :presence => true,
            :length => 5..255
  validates :total,
            :numericality => true,
            :presence => true
  validates :fecha_entrega,
            :presence => true
end
