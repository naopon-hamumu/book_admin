class ApplicationController < ActionController::Base
  before_action :require_login
  def require_login
    # ログインを確認し、非ログイン時にリダイレクトする処理
  end

  before_action do
    redirect_to access_deniede_path if params[:token].blank?
  end
end
