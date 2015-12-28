class HomeController < ApplicationController
  skip_before_action :require_current_user
  skip_before_action :require_complete_profile
  def sign_in
  end
end
