class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'visitor'

  def home; end
end
