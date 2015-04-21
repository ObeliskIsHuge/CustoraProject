# Class represents a single machine instance

class Machine

  # defines getters for our instance variables
  attr_reader :machine_id, :game_id, :terminated


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
      @max_queue_length = 5
    else
      @max_queue_length = 10
    end

  end

  # prints instance variables as a string
  def to_s
    "Machine ID: #{@machine_id} , Game ID: #{game_id}"
  end

  # method updates a machine object after a turn
  def update
    #TODO decrement a turn from everything in queue. Delete values
    # whose turn is now zero. Swap values from the queue to machine as necessary
  end


  # Adds a new job to the machine
  def add_to_machine( job )


    if @memory_available - job.memory  > 0

      @jobs_in_memory.push( job )
      @memory_available -= job.memory
    else
      add_to_queue( job )
    end
  end


  # Determines if this machine should accept more jobs or not
  def canAcceptMoreJobs ( job )

    if @memory_available -  job.memory > 0 || @jobs_in_queue.length <= @max_queue_length
      true
    else
      false
    end
  end


private

  # Adds a new job to the queue
  def add_to_queue ( job )
    @jobs_in_queue.push( job )
  end




end