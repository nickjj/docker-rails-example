class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def create
    person = Person.create(name: "Person #{SecureRandom.hex(4)}")

    ActivatePersonJob.perform_later(person)

    redirect_to people_path
  end
end
