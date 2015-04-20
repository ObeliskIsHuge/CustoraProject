# Class represents a job

class Job

  # defines getters for our instance variables
  attr_reader :id, :turns, :memory

  # Class constructor
  def initialize( id , turns , memory )
    @id = id
    @turns = turns
    @memory = memory
  end

  # Prints the instance variables of the job object
  def to_s
    "Id: #{@id}, Turns left: #{@turns} , Memory required: #{@memory}"
  end

  # Updates jobs after a turn has passed
  def update
    @turns -= 1 unless @turns.zero?
  end
end