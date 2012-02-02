class Seleccion < ActiveRecord::Base
  belongs_to :clientes
  belongs_to :productos
  
  def self.agregar_producto(cliente_id,producto_id)
    producto_actual = Seleccion.where("cliente_id = ? AND producto_id = ?",cliente_id,producto_id).first
    unless producto_actual.nil?
      producto_actual.cantidad += 1
    else
      producto_actual = Seleccion.new(:cliente_id => cliente_id, :producto_id => producto_id, :cantidad => 1)
    end
    producto_actual.save
  end
  
  def ver_producto
    producto = Producto.find(self.producto_id)
    producto
  end
  
  def total_producto
    producto = Producto.find(self.producto_id)
    total = self.cantidad*producto.precio
  end
  
  def self.quitar_producto(cliente_id,producto_id)
    seleccion = Seleccion.where("cliente_id = ? AND producto_id = ?",cliente_id,producto_id)
    seleccion.destroy
  end
  
  def self.vaciar_carro(cliente_id)
    selecciones = Seleccion.where("cliente_id = ?",cliente_id)
    selecciones.each do |seleccion|
      seleccion.destroy
    end
  end
    
  def self.precio_total(cliente_id)
    @selecciones = Seleccion.where("cliente_id = ?",cliente_id)
    total = 0
    @selecciones.each do |seleccion|
      total += total_producto(seleccion.producto_id)
    end
    total
  end
end
