class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :block_foreign_hosts
  # このアクションを追加
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end


  private
  # 配列内にアクセスを許可するIPアドレスを羅列する。
  def whitelisted?(ip)
    return true if [192.168.11.3, 123.43.65.77].include?(ip)
    false
  end

  #　whiltelisted?で許可したIPアドレス以外のアクセスがあれば制限をかける（この場合はgoogle.comに飛ばしている。）
  def block_foreign_hosts
    return false if whitelisted?(request.remote_ip)
    redirect_to "https://www.google.com" unless request.remote_ip.start_with?("123.456.789")
  end

  protected

  # 入力フォームからアカウント名情報をDBに保存するために追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
