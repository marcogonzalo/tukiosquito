class ServiciosController < ApplicationController
  include WashOut::SOAP

  soap_action "prueba",
              :args => :string,
              :return => :string
  def prueba
    render :soap => '<resp><hola>'+params[:value]+'</hola><chao>b</chao></resp>'
  end
end
