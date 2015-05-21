module Scalingo
  module Endpoint
    class Apps < Collection
      def create(name)
        post(nil, {app: {name: name}})
      end

      def find_by
        'name'
      end
    end
    class App < Resource
      def scale(containers)
        post('scale', {containers: containers})
      end

      def restart(*scopes)
        post('restart', {scope: scopes})
      end

      def destroy(current_name)
        delete(nil, {current_name: current_name})
      end

      def destroy!
        destroy(prefix)
      end

      def rename(new_name, current_name)
        post('rename', {new_name: new_name, current_name: current_name})
      end
      def rename!(new_name)
        rename(new_name, prefix)
      end

      def transfer(email)
        patch(nil, {app: {owner: {email: email}}})
      end

      def logs_url
        get('logs')['logs_url']
      end

      def logs
        Scalingo::Logs.new(self)
      end

      def run(command, env = {})
        post('run', {command: command, env: env})
      end

      resources :addons
      resources :collaborators
      resources :deployments
      resources :domains
      resources :variables
      resources :events, collection_only: true
    end
  end
end

