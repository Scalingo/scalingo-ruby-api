require "scalingo/api/endpoint"

module Scalingo
  class Regional::ScmRepoLinks < API::Endpoint
    def show(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {scm_repo_link: payload}

      connection.post(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )
    end

    def update(app_id, payload = {}, headers = nil, &block)
      data = {scm_repo_link: payload}

      connection.patch(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )
    end

    def destroy(app_id, headers = nil, &block)
      data = nil

      connection.delete(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )
    end

    def deploy(app_id, branch, headers = nil, &block)
      data = {branch: branch}

      connection.post(
        "apps/#{app_id}/scm_repo_link/manual_deploy",
        data,
        headers,
        &block
      )
    end

    def review_app(review_app, pull_request_id, headers = nil, &block)
      data = {pull_request_id: pull_request_id}

      connection.post(
        "apps/#{app_id}/scm_repo_link/manual_review_app",
        data,
        headers,
        &block
      )
    end

    def branches(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/scm_repo_link/branches",
        data,
        headers,
        &block
      )
    end

    def pulls(app_id, headers = nil, &block)
      data = nil

      connection.get(
        "apps/#{app_id}/scm_repo_link/pulls",
        data,
        headers,
        &block
      )
    end
  end
end
