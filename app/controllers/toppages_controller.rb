class ToppagesController < ApplicationController
before_action :forbid_login_user, {only: [:index]}
  def index
  end
end
