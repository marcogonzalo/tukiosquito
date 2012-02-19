class ReportesController < ApplicationController
  layout :definir_layout
  
  def index
  end

  def clientes
    @clientes = Orden.select("count(*) AS total_ordenes, cliente_id").group("cliente_id").order('total_ordenes DESC')
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "clientes",
                :template => "reportes/bottom_ten.html.erb",
                :layout => "plantilla.html"
      end
    end
  end

  def categorias
    @categorias = Venta.select("sum(cantidad*costo) AS total, categoria_id").where(:created_at => (params[:fecha_inicio])..(params[:fecha_fin])).group("categoria_id").order('total DESC')
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf     => "categorias",
                :template => "reportes/bottom_ten.html.erb",
                :layout => "plantilla.html"
      end
    end
  end

  def top_ten
    @productos = Venta.select("sum(cantidad*costo) AS total, producto_id, categoria_id").group("producto_id").order('categoria_id ASC, total DESC').limit(10)
    #.where(:created_at => (params[:fecha_inicio])..(params[:fecha_fin]))
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "top_ten",
                :template => "reportes/bottom_ten.html.erb",
                :layout => "plantilla.html"
      end
    end
  end

  def bottom_ten
    @productos = Venta.select("sum(cantidad*costo) AS total, producto_id, categoria_id").group("producto_id").order('categoria_id ASC, total ASC').limit(10)
    #.where(:created_at => (params[:fecha_inicio])..(params[:fecha_fin]))
    respond_to do |format|
      format.html
      format.pdf do
        render  :pdf => "bottom_ten",
                :template => "reportes/bottom_ten.html.erb",
                :layout => "plantilla.html"
      end
    end
  end
  
  private
  def definir_layout
    case action_name
    when "index"
      "cliente"
    else
      "pdf"
    end
  end

end
