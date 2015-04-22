# Class represents a Cluster object
#
# "Cluster" is a group of a machine objects and this class
# is used to manage groups of machines

require_relative 'machine'
require_relative 'job'

class Cluster

  # Creates a getter for machine_set
  attr_reader :machine_set

  # Creates a new Cluster object
  #
  # length will be be true when we're playing the short version
  # length will be false otherwise
  # @param {int} game_id is the id of the game
  # @param {string} is the length of the game
  def initialize ( game_id , length )
    @machine_set = []
    @game_id = game_id
    @length_of_game = length
  end


  # Process a job for the cluster
  #
  # @param job is a job object that will be processed
  def processJob ( job )

    update

    machine_index = findBestMachine

    # will be true when we need to create another machine
    if machine_index != nil
      @machine_set[machine_index].add_to_machine(job)
    else
      new_machine = createNewMachine
      new_machine.add_to_machine ( job )
    end

    clusterCleanUp
  end



private

  # Finds the index of the 'best' machine to add the job to
  #
  # @return {int} index of the best machine to add the job to
  #         {nil} if no machines can add more jobs
  def findBestMachine

    index = 0
    @machine_set.each do |machine|

      if machine.canAcceptMoreJobs
          return index
      end

      index += 1
    end

    nil
  end

  # Creates a new machine. API ENDPOINT NEEDED
  def createNewMachine
    #TODO
  end

  # Removes a machine from the cluster. API ENDPOINT NEEDED
  def removeMachine
    #TODO
  end

  # Updates the cluster and all the data
  def update
    #TODO
  end


  # 'Cleans Up' the cluster. IE. Reallocate jobs as necessary and
  # deletes machines that are no longer needed
  def clusterCleanUp
    #TODO
  end


end