class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:top , :about]
  def top; end

  def about; end
end
