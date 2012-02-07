class OrdenesController < ApplicationController
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
    @peso_total = Seleccion.peso_total(usuario_actual.id)
    @precio_total = Seleccion.precio_total(usuario_actual.id)
    @tarjetas = usuario_actual.tdc
    @orden = Orden.new(:direccion_entrega=>usuario_actual.direccion)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @orden }
    end
  end

  # GET /ordenes/1/edit
  def edit
    @orden = Orden.find(params[:id])
  end

  # POST /ordenes
  # POST /ordenes.json
  def create
    params[:orden][:cliente_id] = usuario_actual.id
    params[:orden][:total] = Seleccion.precio_total(usuario_actual.id)
    params[:orden][:fecha_entrega] = "0000-00-00"
    
    #if
    #else
    #  @orden = Orden.new(params[:orden])
    #  session[:carro] = :nil
    #  Seleccion.vaciar_carro(usuario_actual.id)
      redirect_to_index
    #end
    
    respond_to do |format|
      if @orden.save
        format.html { redirect_to @orden, notice: 'Orden was successfully created.' }
        format.json { render json: @orden, status: :created, location: @orden }
      else
        format.html { render action: "new" }
        format.json { render json: @orden.errors, status: :unprocessable_entity }
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
end
