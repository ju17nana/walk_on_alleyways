class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top about]
  def top
    redirect_to about_path unless logged_in?
  end

  def about; end
end
