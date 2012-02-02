class Producto < ActiveRecord::Base
  has_many :ventas
  has_many :ordenes, :through => :ventas
  has_many :selecciones
  belongs_to :categorias
  belongs_to :subcategorias
  
  validates :nombre,
            :presence => true,
            :length => 5..100
  validates :descripcion,
            :presence => true,
            :length => 5..255
#  validates :categoria_id,
#            :presence => true,
#            :length => 1..3,
#            :numericality => true
#  validates :subcategoria_id,
#            :presence => true,
#            :length => 1..3,
#            :numericality => true
  validates :precio,
            :presence => true,
            :numericality => { :greater_than => 0 },
            :length => 1..7
  validates :cantidad,
            :presence => true,
            :numericality => { :greater_than => 0 },
            :length => 1..5
  validates :peso,
            :presence => true,
            :numericality => true,
            :length => 1..5
  validates :alto,
            :presence => true,
            :numericality => true,
            :length => 1..5
  validates :ancho,
            :presence => true,
            :numericality => true,
            :length => 1..5
  validates :largo,
            :presence => true,
            :numericality => true,
            :length => 1..5
  validates :fecha_fin_venta,
            :presence => true
end
