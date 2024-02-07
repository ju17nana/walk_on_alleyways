class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :info, :warning
  before_action :require_login
end
