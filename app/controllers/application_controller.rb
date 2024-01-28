class ApplicationController < ActionController::Base
  rescue_from LoginFailed, with: :login_failed

  before_action :require_login
  def require_login
    # ログインを確認し、非ログイン時にリダイレクトする処理
  end

  before_action do
    redirect_to access_deniede_path if params[:token].blank?
  end

  def login_failed
    render template: "shared/login_failed", status: 401
  end
end
