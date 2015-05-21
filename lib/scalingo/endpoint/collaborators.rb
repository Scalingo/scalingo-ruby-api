module Scalingo
  module Endpoint
    class Collaborators < Collection
      def create(email)
        post(nil, {collaborator: {email: email}})
      end
    end
    class Collaborator < Resource
      def destroy
        delete
      end
    end
  end
end

