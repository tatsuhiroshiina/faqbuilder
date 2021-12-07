class ApplicationController < ActionController::Base
  before_action :restrict_remote_ip
  before_action :configure_permitted_parameters, if: :devise_controller?

  # このアクションを追加
  def after_sign_in_path_for(resource)
    posts_path
  end


  private
  # 配列内にアクセスを許可するIPアドレスを羅列する。
  PERMIT_ADDRESSES = ['192.168.11.3', '36.2.33.230', '::1'].freeze

  def restrict_remote_ip
  unless PERMIT_ADDRESSES.include?(request.remote_ip)
    redirect_to("https://www.google.com")
  end
  end
  protected

  # 入力フォームからアカウント名情報をDBに保存するために追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
