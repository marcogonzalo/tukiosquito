class AdministradoresController < ApplicationController
#  before_filter :es_admin
#  skip_before_filter :es_admin, :only => [:new, :create]
  # GET /administradores
  # GET /administradores.json
  def index
    @administradores = Administrador.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @administradores }
    end
  end

  # GET /administradores/1
  # GET /administradores/1.json
  def show
    @administrador = Administrador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @administrador }
    end
  end

  # GET /administradores/new
  # GET /administradores/new.json
  def new
    @administrador = Administrador.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @administrador }
    end
  end

  # GET /administradores/1/edit
  def edit
    @administrador = Administrador.find(params[:id])
  end

  # POST /administradores
  # POST /administradores.json
  def create
    @administrador = Administrador.new(params[:administrador])

    respond_to do |format|
      if @administrador.save
        format.html { redirect_to @administrador, notice: 'Administrador was successfully created.' }
        format.json { render json: @administrador, status: :created, location: @administrador }
      else
        format.html { render action: "new" }
        format.json { render json: @administrador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /administradores/1
  # PUT /administradores/1.json
  def update
    @administrador = Administrador.find(params[:id])

    respond_to do |format|
      if @administrador.update_attributes(params[:administrador])
        format.html { redirect_to @administrador, notice: 'Administrador was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @administrador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administradores/1
  # DELETE /administradores/1.json
  def destroy
    @administrador = Administrador.find(params[:id])
    @administrador.destroy

    respond_to do |format|
      format.html { redirect_to administradores_url }
      format.json { head :ok }
    end
  end
  
  def iniciar_sesion  
    admin = Administrador.autenticar(params[:usuario], params[:clave])  
    if admin
      session[:admin_id] = admin.id  
      redirect_to :back, :notice => "Sesi&oacute;n iniciada correctamente."
    else
      flash.now.alert = "Usuario o clave inv&aacute;lidos."
      render "iniciar_sesion"
    end  
  end 
  
  def cerrar_sesion
    session[:admin_id] = nil  
    redirect_to root_url, :notice => "Sesi&oacute;n terminada."  
  end 
end
