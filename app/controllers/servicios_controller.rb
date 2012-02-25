class ServiciosController < ApplicationController
  include WashOut::SOAP

  soap_action "prueba",
              :args => :string,
              :return => :string
  def prueba
    render :soap => params[:value]
  end
end
