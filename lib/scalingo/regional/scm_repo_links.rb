require "scalingo/api/endpoint"

module Scalingo
  class Regional::ScmRepoLinks < API::Endpoint
    def find(app_id)
      response = connection.get("apps/#{app_id}/scm_repo_link")

      unpack(response, key: :scm_repo_link)
    end

    def create(app_id, payload = {})
      data = {scm_repo_link: payload}

      response = connection.post("apps/#{app_id}/scm_repo_link", data)

      unpack(response, key: :scm_repo_link)
    end

    def update(app_id, payload = {})
      data = {scm_repo_link: payload}

      response = connection.patch("apps/#{app_id}/scm_repo_link", data)

      unpack(response, key: :scm_repo_link)
    end

    def destroy(app_id)
      response = connection.delete("apps/#{app_id}/scm_repo_link")

      unpack(response, key: :scm_repo_link)
    end

    def deploy(app_id, branch)
      data = {branch: branch}

      response = connection.post("apps/#{app_id}/scm_repo_link/manual_deploy", data)

      unpack(response, key: :deployment)
    end

    def review_app(review_app, pull_request_id)
      data = {pull_request_id: pull_request_id}

      response = connection.post("apps/#{app_id}/scm_repo_link/manual_review_app", data)

      unpack(response, key: :review_app)
    end

    def branches(app_id)
      response = connection.get("apps/#{app_id}/scm_repo_link/branches")

      unpack(response, key: :branches)
    end

    def pulls(app_id)
      response = connection.get("apps/#{app_id}/scm_repo_link/pulls")

      unpack(response, key: :pulls)
    end
  end
end
