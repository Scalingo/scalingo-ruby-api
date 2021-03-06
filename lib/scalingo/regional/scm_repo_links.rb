require "scalingo/api/endpoint"

module Scalingo
  class Regional::ScmRepoLinks < API::Endpoint
    def show(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )

      unpack(:scm_repo_link) { response }
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {scm_repo_link: payload}

      response = connection.post(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )

      unpack(:scm_repo_link) { response }
    end

    def update(app_id, payload = {}, headers = nil, &block)
      data = {scm_repo_link: payload}

      response = connection.patch(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )

      unpack(:scm_repo_link) { response }
    end

    def destroy(app_id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )

      unpack(:scm_repo_link) { response }
    end

    def deploy(app_id, branch, headers = nil, &block)
      data = {branch: branch}

      response = connection.post(
        "apps/#{app_id}/scm_repo_link/manual_deploy",
        data,
        headers,
        &block
      )

      unpack(:deployment) { response }
    end

    def review_app(review_app, pull_request_id, headers = nil, &block)
      data = {pull_request_id: pull_request_id}

      response = connection.post(
        "apps/#{app_id}/scm_repo_link/manual_review_app",
        data,
        headers,
        &block
      )

      unpack(:review_app) { response }
    end

    def branches(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/scm_repo_link/branches",
        data,
        headers,
        &block
      )

      unpack(:branches) { response }
    end

    def pulls(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/scm_repo_link/pulls",
        data,
        headers,
        &block
      )

      unpack(:pulls) { response }
    end
  end
end
