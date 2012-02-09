class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :usuario_actual
  helper_method :admin_actual
  
  def es_usuario
    unless usuario_identificado?
      flash[:error] = "Debe identificarse en el sistema para acceder."
      session[:back] = :back
      redirect_to iniciar_sesion_cliente_path
    end
  end
  
  def es_admin
    unless admin_identificado?
      flash[:error] = "Debe identificarse en el sistema para acceder."
      redirect_to iniciar_sesion_admin_path
    end
  end

  private
  def usuario_actual  
    @usuario_actual ||= Cliente.find(session[:cliente_id]) if session[:cliente_id]
  end
  
  def admin_actual  
    @admin_actual ||= Administrador.find(session[:admin_id]) if session[:admin_id]
  end
  
  def usuario_identificado?
    !!usuario_actual
  end
  
  def admin_identificado?
    !!admin_actual
  end
end
