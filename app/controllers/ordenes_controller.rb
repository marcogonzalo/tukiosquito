class OrdenesController < ApplicationController
  #require 'httpclient'
  #require 'soap/rpc/driver'
  #require 'rubygems'
  require 'xmlsimple'
  require 'savon'
  
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
        
        client = Savon::Client.new("http://localhost:3001/servicios/wsdl")
        response = client.request :prueba, body: { "value" => "prueba" }  
        if response.success?  
          data = response.to_hash[:prueba_response][:value]
          @respuesta = XmlSimple.xml_in(data)
        end
   
        #@respuesta = response.to_xml
        #@arreglo = XmlSimple.xml_in('')
        #@xml = XmlSimple.xml_out(@arreglo, { 'RootName' => 'solicitud_pedido' })
        #url = 'http://192.168.1.101/Antonio/tukyosquito/proyecto/servicio/servicio.php'
        #cotizacion = SOAP::RPC::Driver.new(url)
        #cotizacion.add_method('obtener','asd')
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
    
    client = Savon::Client.new("http://localhost:3001/servicios/wsdl")
    pago = '<Message>
              <Request>
                <numero_tdc>'+numero_tdc+'</numero_tdc>
                <nombre_tarjetahabiente>'+nombre_tarjetahabiente+'</nombre_tarjetahabiente>
                <fecha_vencimiento>'+fecha_vencimiento+'</fecha_vencimiento>
                <codigo_seguridad>'+codigo_seguridad+'</codigo_seguridad>
                <tipo_tarjeta>'+tipo_tarjeta+'</tipo_tarjeta>
                <direccion_cobro>'+direccion_cobro+'</direccion_cobro>
                <total_pagar>'+total_pagar+'</total_pagar>
                <cuenta_receptora>'+cuenta_receptora+'</cuenta_receptora>
                <Fecha>'+fecha+'</Fecha>
                <Hora>'+hora+'</Hora>
              </Request>
            </Message>'
    response = client.request :verificar_pago, body: { "value" => pago }  
    if response.success?  
      data = response.to_hash[:verificar_pago_response][:value]
      @respuesta = XmlSimple.xml_in(data)
    end

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
        p = Producto.find(seleccion.producto_id)
        @venta = Venta.new(:producto_id=>p.id, 
                            :orden_id=>@orden.id,
                            :categoria_id=>p.categoria_id, 
                            :cantidad=>seleccion.cantidad,
                            :costo=>p.precio)#params[:venta])
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
