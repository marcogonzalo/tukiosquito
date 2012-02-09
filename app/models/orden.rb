class Orden < ActiveRecord::Base
  has_one :factura_distribuidor
  has_many :ventas
  has_many :productos, :through => :ventas
  belongs_to :tdc
  belongs_to :clientes
  
  validates :cliente_id,
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
#  validates :fecha_entrega,
#            :presence => true
end
