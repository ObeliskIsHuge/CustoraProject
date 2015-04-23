# Class represents a job

class Job

  # defines getters for our instance variables
  attr_reader :id, :turns_left, :memory , :rating

  # Class constructor
  def initialize( id , turns , memory )
    @id = id
    @turns_left = turns
    @memory = memory
    @rating = turns + memory
  end

  # Prints the instance variables of the job object
  def to_s
    "Id: #{@id}, Turns left: #{@turns_left} , Memory required: #{@memory}"
  end

  # Updates jobs after a turn has passed
  def update
    @turns_left -= 1 unless @turns_left.zero?
  end
end