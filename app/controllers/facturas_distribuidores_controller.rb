class FacturasDistribuidoresController < ApplicationController
  # GET /facturas_distribuidores
  # GET /facturas_distribuidores.json
  def index
    @facturas_distribuidores = FacturaDistribuidor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facturas_distribuidores }
    end
  end

  # GET /facturas_distribuidores/1
  # GET /facturas_distribuidores/1.json
  def show
    @factura_distribuidor = FacturaDistribuidor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @factura_distribuidor }
    end
  end

  # GET /facturas_distribuidores/new
  # GET /facturas_distribuidores/new.json
  def new
    @factura_distribuidor = FacturaDistribuidor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @factura_distribuidor }
    end
  end

  # GET /facturas_distribuidores/1/edit
  def edit
    @factura_distribuidor = FacturaDistribuidor.find(params[:id])
  end

  # POST /facturas_distribuidores
  # POST /facturas_distribuidores.json
  def create
    @factura_distribuidor = FacturaDistribuidor.new(params[:factura_distribuidor])

    respond_to do |format|
      if @factura_distribuidor.save
        format.html { redirect_to @factura_distribuidor, notice: 'Factura distribuidor was successfully created.' }
        format.json { render json: @factura_distribuidor, status: :created, location: @factura_distribuidor }
      else
        format.html { render action: "new" }
        format.json { render json: @factura_distribuidor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facturas_distribuidores/1
  # PUT /facturas_distribuidores/1.json
  def update
    @factura_distribuidor = FacturaDistribuidor.find(params[:id])

    respond_to do |format|
      if @factura_distribuidor.update_attributes(params[:factura_distribuidor])
        format.html { redirect_to @factura_distribuidor, notice: 'Factura distribuidor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @factura_distribuidor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facturas_distribuidores/1
  # DELETE /facturas_distribuidores/1.json
  def destroy
    @factura_distribuidor = FacturaDistribuidor.find(params[:id])
    @factura_distribuidor.destroy

    respond_to do |format|
      format.html { redirect_to facturas_distribuidores_url }
      format.json { head :ok }
    end
  end
end
