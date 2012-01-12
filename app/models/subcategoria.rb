class Subcategoria < ActiveRecord::Base
  belongs_to :categorias
  has_many :productos
  
  validates :nombre,
            :presence => true,
            :length => 5..50
  validates :descripcion,
            :presence => false,
            :length => 5..250
  validates :categoria_id,
            :presence => true,
            :numericality => { :greater_than => 0 },
            :length => 1..3
end
