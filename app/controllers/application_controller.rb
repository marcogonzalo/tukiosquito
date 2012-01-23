class ApplicationController < ActionController::Base
  protect_from_forgery  
  helper_method :usuario_actual  
    
  private  
  def usuario_actual  
    @usuario_actual ||= Cliente.find(session[:cliente_id]) if session[:cliente_id]
  end
end
