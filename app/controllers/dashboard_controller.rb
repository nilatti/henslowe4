class DashboardController < ApplicationController
  def index
    @theaters = Theater.all
    @productions = Production.all
    @authors = Author.all
    @plays = Play.all
    @specializations = Specialization.all
  end

end
