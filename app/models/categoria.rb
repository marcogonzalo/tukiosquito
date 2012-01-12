class Categoria < ActiveRecord::Base
  has_many :subcategorias
  has_many :productos
  
  validates :nombre,
            :presence => true,
            :lenght => 5..50
  validates :descripcion,
            :presence => false,
            :lenght => 5..250
end
