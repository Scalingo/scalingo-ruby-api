module Scalingo
  module Endpoint
    class Domains < Collection
      def create(name, tlscert = nil, tlskey = nil)
        if tlskey
          post(nil, domain: { name: name, tlscert: tlscert, tlskey: tlskey })
        else
          post(nil, domain: { name: name })
        end
      end
    end
    class Domain < Resource
      def update(tlscert, tlskey)
        path(nil, domain: { tlscert: tlscert, tlskey: tlskey })
      end

      def destroy
        delete
      end
    end
  end
end
