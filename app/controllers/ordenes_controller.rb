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
        t = Time.now
        fecha = t.strftime("%Y-%m-%d")
        client = Savon::Client.new("http://192.168.1.121/DistribuidorFIF/webservices/servicio.php?wsdl")
        preorden = "<solicitud_pedido>
                        <num_orden>001</num_orden>
                        <nombre_comercio>Tukiosquito</nombre_comercio>
                        <fecha_solicitud>"+fecha.to_s+"</fecha_solicitud>
                        <nombre_cliente>"+usuario_actual.nombre+" "+usuario_actual.apellido+"</nombre_cliente>
                        <direccion_comercio>
                          <avenida>Sucre</avenida>
                          <calle>-</calle>
                          <edificio_casa>CC Millenium</edificio_casa>
                          <local_apt>C1-15</local_apt>
                          <parroquia>Leoncio Martinez</parroquia>
                          <municipio>Sucre</municipio>
                          <ciudad>Caracas</ciudad>
                          <estado>Miranda</estado>
                          <pais>Venezuela</pais>
                        </direccion_comercio>
                        <direccion_destino>
                          <avenida>Santa Rosa</avenida>
                          <calle>Tierras Rojas</calle>
                          <edificio_casa>Villa Magica</edificio_casa>
                          <local_apt>69</local_apt>
                          <parroquia> </parroquia>
                          <municipio>Zamora</municipio>
                          <ciudad>Cua</ciudad>
                          <estado>Miranda</estado>
                          <pais>Venezuela</pais>
                        </direccion_destino>"
        @selecciones.each do |seleccion|
          p = Producto.find(seleccion.producto_id)
          preorden = preorden+"
                        <articulo>
                          <id>"+p.id.to_s+"</id>
                          <descripcion>"+p.descripcion+"</descripcion>
                          <peso>"+p.peso.to_s+"</peso>
                          <cantidad>"+seleccion.cantidad.to_s+"</cantidad>
                          <precio>"+p.precio.to_s+"</precio>
                        </articulo>"
        end
        preorden = preorden+"</solicitud_pedido>"
        response = client.request :ejemplo, body: { "value" => preorden }  
        if response.success?  
          respuesta = response.to_hash[:ejemplo_response][:return]
          datos = XmlSimple.xml_in(respuesta)
        end

        @precio_envio = datos["num_orden"][0]
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
    
    #Cobro en el banco
    client = Savon::Client.new("http://localhost:3001/servicios/wsdl")
    tdc = Tarjeta.where("id = ? AND cliente_id = ?",params[:orden][:tarjeta_id],usuario_actual.id)
    total_pagar = params[:orden][:total]
    pago = '<Message>
              <Request>
                <numero_tdc>'+tdc.numero+'</numero_tdc>
                <nombre_tarjetahabiente>'+tdc.tarjetahabiente+'</nombre_tarjetahabiente>
                <fecha_vencimiento>'+tdc.mes_vencimiento+'/'+tdc.ano_vencimiento+'</fecha_vencimiento>
                <codigo_seguridad>'+tdc.codigo+'</codigo_seguridad>
                <tipo_tarjeta>'+tdc.tipo+'</tipo_tarjeta>
                <direccion_cobro>'+tdc.direccion+'</direccion_cobro>
                <total_pagar>'+total_pagar+'</total_pagar>
                <cuenta_receptora>'+cuenta_receptora+'</cuenta_receptora>
              </Request>
            </Message>'
    #response = client.request :verificar_pago, body: { "value" => pago }  
    #if response.success?
    #  data = response.to_hash[:verificar_pago_response][:value][:response].first
    #  @respuesta = XmlSimple.xml_in(data)
    #end

    #NAMESPACE = 'pagotdc'
    #URL = 'http://localhost:8080/'
    #banco = SOAP::RPC::Driver.new(URL, NAMESPACE)
    #banco.add_method('verificar_pago', 'numero_tdc', 'nombre_tarjetahabiente', 'fecha_vencimiento', 'codigo_seguridad', 'tipo_tarjeta', 'direccion_cobro', 'total_pagar', 'cuenta_receptora')
    #
    
    #respuesta = banco.verificar_pago(tdc.numero, tdc.tarjetahabiente, tdc.mes_vencimiento.to_s+'/'+tdc.ano_vencimiento.to_s, tdc.codigo, tdc.tipo, params[:orden][:total], tdc.direccion)
    
    if true #respuesta.ack.eql?(0)
      params[:orden][:cliente_id] = usuario_actual.id
      params[:orden][:total] = Seleccion.precio_total(usuario_actual.id)
      params[:orden][:fecha_entrega] = "0000-00-00"
      @orden = Orden.new(params[:orden])
    
      if @orden.save
        @selecciones = Seleccion.where("cliente_id = ?",usuario_actual.id)
        @selecciones.each do |seleccion|
          p = Producto.find(seleccion.producto_id)
          @venta = Venta.new(:producto_id=>p.id, 
                              :orden_id=>@orden.id,
                              :categoria_id=>p.categoria_id, 
                              :cantidad=>seleccion.cantidad,
                              :costo=>p.precio)
          @venta.save
        end
        
        Seleccion.vaciar_carro(usuario_actual.id)
        respond_to do |format|
          format.html { redirect_to ver_ordenes_path, notice: 'Orden generada correctamente.' }
        end
      else
        respond_to do |format|
          format.html { render action: "new" }
        end
      end
    else
      respond_to do |format|
        format.html { render action: "new", notice: respuesta.mensaje }
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
