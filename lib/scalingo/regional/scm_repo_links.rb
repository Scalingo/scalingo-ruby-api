require "scalingo/api/endpoint"
{
  "pull_request_id": 42
}
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

      unpack(response, key: :scm_repo_link)
    end

    def create(app_id, payload = {}, headers = nil, &block)
      data = {scm_repo_link: payload}

      response = connection.post(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )

      unpack(response, key: :scm_repo_link)
    end

    def update(app_id, payload = {}, headers = nil, &block)
      data = {scm_repo_link: payload}

      response = connection.patch(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )

      unpack(response, key: :scm_repo_link)
    end

    def destroy(app_id, headers = nil, &block)
      data = nil

      response = connection.delete(
        "apps/#{app_id}/scm_repo_link",
        data,
        headers,
        &block
      )

      unpack(response, key: :scm_repo_link)
    end

    def deploy(app_id, branch, headers = nil, &block)
      data = {branch: branch}

      response = connection.post(
        "apps/#{app_id}/scm_repo_link/manual_deploy",
        data,
        headers,
        &block
      )

      unpack(response, key: :deployment)
    end

    def review_app(review_app, pull_request_id, headers = nil, &block)
      data = {pull_request_id: pull_request_id}

      response = connection.post(
        "apps/#{app_id}/scm_repo_link/manual_review_app",
        data,
        headers,
        &block
      )

      unpack(response, key: :review_app)
    end

    def branches(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/scm_repo_link/branches",
        data,
        headers,
        &block
      )

      unpack(response, key: :branches)
    end

    def pulls(app_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "apps/#{app_id}/scm_repo_link/pulls",
        data,
        headers,
        &block
      )

      unpack(response, key: :pulls)
    end
  end
end
