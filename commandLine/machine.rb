# Class represents a single machine instance

require_relative 'job'
require_relative 'apiEndpoints'


class Machine

  # defines getters for our instance variables
  attr_reader :machine_id, :game_id, :terminated , :memory_available


  # class constructor
  # @param machine_id is the id of the machine
  # @param game_id is the id of the game
  # @param game_length is the length of the game
  def initialize ( machine_id , game_id , game_length )
    @machine_id = machine_id
    @game_id = game_id
    @jobs_in_queue = []
    @jobs_in_memory = []
    @memory_available = 64
    @terminated = false #TODO this may be unnecessary

    # Determines how long we want our job queue to be
    if game_length.eql?('short')
      @max_queue_length = 20
    else
      @max_queue_length = 40
    end

  end

  # prints instance variables as a string
  def to_s
    "Machine ID: #{@machine_id} , Game ID: #{game_id}"
  end

  # method updates the machine object
  def update

    index = 0
    @jobs_in_memory.each do |job|
      job.update

      # Will be true when we can delete the job
      if job.turns_left == 0
        @memory_available += job.memory
        @jobs_in_memory.delete_at(index)
      end
      index += 1
    end

    from_queue_to_memory
  end


  # Adds a new job to the machine
  #
  # @param job is the job that will be added
  def add_to_machine( job )


    if @memory_available - job.memory  > 0

      add_to_memory ( job )
    else
      add_to_queue( job )
    end
  end

  # Returns the sum of turns left
  #
  # @return some of the turns left
  def average_turns_left
    sum_of_turns = 0

    @jobs_in_memory.each do |job|
      sum_of_turns += job.turns_left - 1
    end

    sum_of_turns
  end

  # Returns the sum of the memory that will be free next turn
  #
  # @return int of soon to be freed memory
  def memory_free_next_turn
    free_memory = 0

    @jobs_in_memory.each do |job|
      if job.turns_left == 1
        free_memory += job.memory
      end
    end

    free_memory
  end


  # Determines if the queue is empty
  #
  # @return true if queue is empty
  #         false otherwise
  def queue_empty

    if @jobs_in_queue.empty?
      return true
    end

    false
  end

  # Returns the average rating of the queue
  #
  # @return rating of the queue
  def average_rating_of_queue
    sum_of_rating = 0

    @jobs_in_queue.each do |job|
      sum_of_rating += job.rating
    end

    sum_of_rating / @jobs_in_queue.count
  end


  # Determines if this machine should accept more jobs or not
  def should_accept_more_jobs ( job )

    if @memory_available -  job.memory > 0 || @jobs_in_queue.length <= @max_queue_length
      true
    else
      false
    end
  end


private

  # Adds a new job to the queue
  def add_to_queue ( job )

    temp_array = Array.new
    temp_array.push( job.id )
    @jobs_in_queue.push( job )
    assignJobs(@game_id , @machine_id , temp_array)

    raise 'Too many jobs in queue' if @jobs_in_queue.count > @max_queue_length
  end

  # Adds a job to the memory array and api endpoint
  #
  # @param job is the job that will be assigned
  def add_to_memory ( job )

    @memory_available -= job.memory

    # Will be true when an error was made somewhere
    raise 'Memory Overflow' if @memory_available < 0

    temp_array = []
    temp_array << job.id
    @jobs_in_memory.push( job )
    assignJobs(@game_id , @machine_id , temp_array)
  end

  # moves queued jobs to memory
  def from_queue_to_memory

    if @memory_available > 0

      index = 0
      # Keeps moving values over until memory is full
      @jobs_in_queue.each do |job|

        if @memory_available - job.memory > 0
          @jobs_in_memory.push( job )
          @memory_available -= job.memory
          @jobs_in_queue.delete_at(index)
          index += 1
        else
          break
        end
      end

    end

  end



end