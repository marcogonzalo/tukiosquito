class OrdenesController < ApplicationController
  require 'httpclient'
  require 'soap/rpc/driver'
  require 'rubygems'
  require 'xmlsimple'
  
  layout :definir_layout
  before_filter :es_usuario
  skip_before_filter :es_usuario, :only=>[:new, :create]
  # GET /ordenes
  # GET /ordenes.json
  def index
    @ordenes = Orden.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ordenes }
    end
  end

  # GET /ordenes/1
  # GET /ordenes/1.json
  def show
    @orden = Orden.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @orden }
    end
  end

  # GET /ordenes/new
  # GET /ordenes/new.json
  def new
    
    @selecciones = Seleccion.where("cliente_id = ?",usuario_actual.id)
    respond_to do |format|
      unless @selecciones.empty?
        @peso_total = Seleccion.peso_total(usuario_actual.id)
        @precio_total = Seleccion.precio_total(usuario_actual.id)
        @tarjetas = usuario_actual.tdc
        @orden = Orden.new(:direccion_entrega=>usuario_actual.direccion)
        @arreglo = XmlSimple.xml_in('<solicitud_pedido>
    <num_orden>2312</num_orden>
    <nombre_comercio>23123</nombre_comercio>
    <fecha_solicitud>123213</fecha_solicitud>
    <nombre_cliente>213123</nombre_cliente>
    <direccion_comercio>
        <avenida>213123</avenida>
        <calle>213123</calle>
        <edificio_casa></edificio_casa>
        <local_apt></local_apt>
        <parroquia></parroquia>
        <municipio></municipio>
        <ciudad></ciudad>
        <estado></estado>
        <pais></pais>
    </direccion_comercio>
    <direccion_destino>
        <avenida></avenida>
        <calle></calle>
        <edificio_casa></edificio_casa>
        <local_apt></local_apt>
        <parroquia> </parroquia>
        <municipio></municipio>
        <ciudad></ciudad>
        <estado></estado>
        <pais></pais>   
    </direccion_destino>
    <articulo>
        <id></id>
        <descripcion></descripcion>
        <peso></peso>
        <cantidad></cantidad>
        <precio></precio>
    </articulo>
    <articulo>
        <id>1</id>
        <descripcion></descripcion>
        <peso></peso>
        <cantidad></cantidad>
        <precio></precio>
    </articulo>
    <articulo>
        <id>2</id>
        <descripcion></descripcion>
        <peso></peso>
        <cantidad></cantidad>
        <precio></precio>
    </articulo>
</solicitud_pedido>')
        #@xml = XmlSimple.xml_out(@arreglo, { 'RootName' => 'solicitud_pedido' })
        url = 'http://192.168.1.101/Antonio/tukyosquito/proyecto/servicio/servicio.php'
        cotizacion = SOAP::RPC::Driver.new(url)
        cotizacion.add_method('obtener','asd')
        #tdc = Tarjeta.where("id = ? AND cliente_id = ?",params[:orden][:tarjeta_id],usuario_actual.id)
        #@respuesta = cotizacion.obtener('123')
        format.html # new.html.erb
      else
        format.html { redirect_to carrito_path, notice: 'No tiene productos agregados al carro de compras para generar una orden.' }
      end
    end
  end

  # GET /ordenes/1/edit
  def edit
    @orden = Orden.find(params[:id])
  end

  # POST /ordenes
  # POST /ordenes.json
  def create
    @selecciones = Seleccion.where("cliente_id = ?",usuario_actual.id)
    @peso_total = Seleccion.peso_total(usuario_actual.id)
    @precio_total = Seleccion.precio_total(usuario_actual.id)
    @tarjetas = usuario_actual.tdc
    params[:orden][:cliente_id] = usuario_actual.id
    params[:orden][:total] = Seleccion.precio_total(usuario_actual.id)
    params[:orden][:fecha_entrega] = "0000-00-00"
    
    #NAMESPACE = 'pagotdc'
    #URL = 'http://localhost:8080/'
    #banco = SOAP::RPC::Driver.new(URL, NAMESPACE)
    #banco.add_method('verificar_pago', 'numero_tdc', 'nombre_tarjetahabiente', 'fecha_vencimiento', 'codigo_seguridad', 'tipo_tarjeta', 'direccion_cobro', 'total_pagar', 'cuenta_receptora')
    #tdc = Tarjeta.where("id = ? AND cliente_id = ?",params[:orden][:tarjeta_id],usuario_actual.id)
    
    #respuesta = banco.verificar_pago(tdc.numero, tdc.tarjetahabiente, tdc.mes_vencimiento.to_s+'/'+tdc.ano_vencimiento.to_s, tdc.codigo, tdc.tipo, params[:orden][:total], tdc.direccion)
    
    #if error.eql?(0)
      @orden = Orden.new(params[:orden])
    #end
    
    if @orden.save
      @selecciones = Seleccion.where("cliente_id = ?",usuario_actual.id)
      @selecciones.each do |seleccion|
        #params[:venta][:producto_id] = seleccion.producto_id
        #params[:venta][:orden_id] = @orden.id
        #params[:venta][:cantidad] = seleccion.cantidad
        #params[:venta][:costo] = 0
        @venta = Venta.new(:producto_id=>seleccion.producto_id, 
                            :orden_id=>@orden.id,
                            :cantidad=>seleccion.cantidad,
                            :costo=>0)#params[:venta])
        @venta.save
      end
      Seleccion.vaciar_carro(usuario_actual.id)
      respond_to do |format|
        format.html { redirect_to ver_ordenes_path, notice: 'Orden generada correctamente.' }
        #format.json { render json: @orden, status: :created, location: @orden }
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
        #format.json { render json: @orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ordenes/1
  # PUT /ordenes/1.json
  def update
    @orden = Orden.find(params[:id])

    respond_to do |format|
      if @orden.update_attributes(params[:orden])
        format.html { redirect_to @orden, notice: 'Orden was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordenes/1
  # DELETE /ordenes/1.json
  def destroy
    @orden = Orden.find(params[:id])
    @orden.destroy

    respond_to do |format|
      format.html { redirect_to ordenes_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def definir_layout
    case action_name
    when "new"
      "cliente"
    else
      "application"
    end
  end
end
