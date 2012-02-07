class TdcController < ApplicationController
  # GET /tdc
  # GET /tdc.json
  def index
    @tdc = Tdc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tdc }
    end
  end

  # GET /tdc/1
  # GET /tdc/1.json
  def show
    @tdc = Tdc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tdc }
    end
  end

  # GET /tdc/new
  # GET /tdc/new.json
  def new
    @tdc = Tdc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tdc }
    end
  end

  # GET /tdc/1/edit
  def edit
    @tdc = Tdc.find(params[:id])
  end

  # POST /tdc
  # POST /tdc.json
  def create
    params[:tdc][:cliente_id] = usuario_actual.id
    @tdc = Tdc.new(params[:tdc])

    respond_to do |format|
      if @tdc.save
        format.html { redirect_to @tdc, notice: 'Tdc was successfully created.' }
        format.json { render json: @tdc, status: :created, location: @tdc }
      else
        format.html { render action: "new" }
        format.json { render json: @tdc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tdc/1
  # PUT /tdc/1.json
  def update
    @tdc = Tdc.find(params[:id])
    params[:tdc][:cliente_id] = @tdc.cliente_id
    respond_to do |format|
      if @tdc.update_attributes(params[:tdc])
        format.html { redirect_to @tdc, notice: 'Tdc was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tdc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tdc/1
  # DELETE /tdc/1.json
  def destroy
    @tdc = Tdc.find(params[:id])
    @tdc.destroy

    respond_to do |format|
      format.html { redirect_to tdc_index_url }
      format.json { head :ok }
    end
  end
end
