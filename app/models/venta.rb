class Venta < ActiveRecord::Base
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
