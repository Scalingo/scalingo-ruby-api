require "scalingo/api/endpoint"

module Scalingo
  class Regional::ScmRepoLinks < API::Endpoint
    get :show, "/apps/{app_id}/scm_repo_link"
    get :branches, "/apps/{app_id}/scm_repo_link/branches"
    get :pulls, "/apps/{app_id}/scm_repo_link/pulls"
    post :create, "/apps/{app_id}/scm_repo_link", root_key: :scm_repo_link
    post :deploy, "/apps/{app_id}/scm_repo_link/manual_deploy"
    post :review_app, "/apps/{app_id}/scm_repo_link/manual_review_app"
    patch :update, "/apps/{app_id}/scm_repo_link", root_key: :scm_repo_link
    delete :destroy, "/apps/{app_id}/scm_repo_link"
  end
end
