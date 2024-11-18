class ActivatePersonJob < ApplicationJob
  queue_as :default

  def perform(person)
    person.update(active: true)
  end
end
