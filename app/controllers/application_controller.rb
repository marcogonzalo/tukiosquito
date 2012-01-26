class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :usuario_actual
  helper_method :admin_actual
  
  def es_usuario
  end
  
  def es_admin
  end

  private
  def usuario_actual  
    @usuario_actual ||= Cliente.find(session[:cliente_id]) if session[:cliente_id]
  end
  
  def admin_actual  
    @admin_actual ||= Administrador.find(session[:admin_id]) if session[:admin_id]
  end
end
