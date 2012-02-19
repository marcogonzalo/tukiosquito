require "soap/rpc/standaloneserver"

begin
  class Servidor < SOAP::RPC::StandaloneServer
    def initialize(*args)
      add_method(self, 'add', 'a', 'b')
    end
    # Handler methods
    def add(a, b)
      return a + b
    end
  end
  server = Servidor.new("Servidor", 
            'servicio', 'localhost', 8080)
  server.start
end
