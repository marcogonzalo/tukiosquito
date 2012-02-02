class TiendaController < ApplicationController
  def index
    @categorias = Categoria.all
    cat = params[:cat_id].to_i
    subcat = params[:subcat_id].to_i
    if cat > 0 then
      @cat_actual = Categoria.where("id = ?",cat).first
      @subcategorias = Subcategoria.where("categoria_id = ?",cat)
      if subcat > 0 then
        @subcat_actual = Subcategoria.where("id = ?",subcat).first
        @productos = Producto.where("categoria_id = ? AND subcategoria_id = ?",cat,subcat)
      else
        @productos = Producto.where("categoria_id = ? ",cat)
      end
    else
      @categorias = Categoria.all
      @subcategorias = Subcategoria.all
      @productos = Producto.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @productos }
    end
  end
  
  def carrito
    @selecciones = usuario_actual.selecciones

    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def agregar_al_carro
    producto = Producto.find(params[:id])
    Seleccion.agregar_producto(usuario_actual.id,producto.id)
    redirect_to carrito_path
    #rescue ActiveRecord::RecordNotFound
    #  logger.error("Producto indicado no existe")
    #  redirect_to_index("Producto inexistente")
    #end
  end
  
  def quitar_del_carro
    seleccion = Seleccion.find(params[:id])
    seleccion.destroy
    redirect_to carrito_path
  end
  
  def vaciar_carro
    session[:carro] = :nil
    redirect_to_index
  end
  
  private
  def redirect_to_index(msg=nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end
end
