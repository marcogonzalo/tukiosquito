class SubcategoriasController < ApplicationController
  # GET /subcategorias
  # GET /subcategorias.json
  def index
    @subcategorias = Subcategoria.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subcategorias }
    end
  end

  # GET /subcategorias/1
  # GET /subcategorias/1.json
  def show
    @subcategoria = Subcategoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subcategoria }
    end
  end

  # GET /subcategorias/new
  # GET /subcategorias/new.json
  def new
    @categorias = Categoria.all
    @subcategoria = Subcategoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subcategoria }
    end
  end

  # GET /subcategorias/1/edit
  def edit
    @categorias = Categoria.all
    @subcategoria = Subcategoria.find(params[:id])
  end

  # POST /subcategorias
  # POST /subcategorias.json
  def create
    @subcategoria = Subcategoria.new(params[:subcategoria])

    respond_to do |format|
      if @subcategoria.save
        format.html { redirect_to @subcategoria, notice: 'Subcategoria was successfully created.' }
        format.json { render json: @subcategoria, status: :created, location: @subcategoria }
      else
        format.html { render action: "new" }
        format.json { render json: @subcategoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subcategorias/1
  # PUT /subcategorias/1.json
  def update
    @subcategoria = Subcategoria.find(params[:id])

    respond_to do |format|
      if @subcategoria.update_attributes(params[:subcategoria])
        format.html { redirect_to @subcategoria, notice: 'Subcategoria was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @subcategoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subcategorias/1
  # DELETE /subcategorias/1.json
  def destroy
    @subcategoria = Subcategoria.find(params[:id])
    @subcategoria.destroy

    respond_to do |format|
      format.html { redirect_to subcategorias_url }
      format.json { head :ok }
    end
  end
end
