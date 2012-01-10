class Venta < ActiveRecord::Base
  belongs_to :ordenes
  belongs_to :productos
  
  validates :producto_id,
            :presence => true,
            :numericality => { :only_integer => true }
  validates :orden_id,
            :presence => true,
            :numericality => { :only_integer => true }
  validates :cantidad,
            :presence => true,
            :numericality => { :only_integer => true }
  validates :costo,
            :presence => true,
            :numericality => true
end
