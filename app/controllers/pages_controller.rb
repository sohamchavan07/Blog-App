class PagesController < ApplicationController
  layout false, only: [ :home ]

  def home
  end
end
