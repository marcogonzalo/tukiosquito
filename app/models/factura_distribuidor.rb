class FacturaDistribuidor < ActiveRecord::Base
  belongs_to :orden
  
  validates :orden_id,
            :presence => true
  validates :distribuidor,
            :presence => true,
            :length => 5..100
  validates :numero_orden,
            :presence => true
  validates :total,
            :presence => true
  validates :fecha_entrega,
            :presence => true
end
