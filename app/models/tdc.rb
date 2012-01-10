class Tdc < ActiveRecord::Base
  belongs_to :clientes
  has_one :orden
  
  TIPO_TDC = ["Visa","Mastercard"]
  validates :numero,
            :presence => true,
            :numericality => { 
                                :only_integer => true,
                                :greater_than => 0
                             }, 
            :length => { :is => 16 }
  validates :tipo, 
            :presence => true,
            :inclusion => { :in => TIPO_TDC.map {|tipo_tdc| tipo_tdc} }
  validates :codigo, 
            :presence => true,
            :numericality => { 
                                :only_integer => true,
                                :greater_than => 0
                             }, 
            :length => { :is => 3 }
  validates :mes_vencimiento, 
            :presence => true,
            :numericality => true,
            :inclusion => { :in => 1..12 }, 
            :length => { :is => 2 }
  validates :ano_vencimiento, 
            :presence => true,
            :numericality => true,
            :inclusion => { :in => 0..99 }, 
            :length => { :is => 2 }
  validates :direccion, 
            :presence => true,
            :length => 5..255
  validates :tarjetahabiente,
            :presence => true,
            :length => 5..100
end
