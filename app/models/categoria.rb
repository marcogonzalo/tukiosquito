class Categoria < ActiveRecord::Base
  has_many :subcategorias
  has_many :productos
  has_many :ventas
  
  validates :nombre,
            :presence => true,
            :length => 5..50
  validates :descripcion,
            :presence => false,
            :length => 5..250
end
