class ApplicationController < ActionController::Base
  rescue_from LoginFailed, with: :login_failed

  before_action :require_login
  def require_login
    # ログインを確認し、非ログイン時にリダイレクトする処理
  end

  # before_action do
  #   redirect_to access_denied_path if params[:token].blank?
  # end

  def login_failed
    render template: "shared/login_failed", status: 401
  end

  # コントローラー内でビューのテンプレートとして展開されるファイルを選択できるようにする
  def detect_mobile_variant
    request.variant = :mobile if request.user_agent =~ /iPhone/
  end
end
