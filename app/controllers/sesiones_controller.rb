class SesionesController < ApplicationController
  def new
  end

  def create  
    cliente = Cliente.autenticar(params[:usuario], params[:clave])  
    if cliente
      session[:cliente_id] = cliente.id  
      redirect_to :back, :notice => "Sesi&oacute;n iniciada correctamente."
    else
      flash.now.alert = "Usuario o clave inv&aacute;lidos."
      render "new"
    end  
  end 
  
  def destroy  
    session[:cliente_id] = nil  
    redirect_to root_url, :notice => "Sesi&oacute;n terminada."  
  end   
end
