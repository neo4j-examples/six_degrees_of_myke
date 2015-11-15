class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:name])
  end
end
