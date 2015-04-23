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
    @machine_set = Array.new
    @game_id = game_id
    @length_of_game = length
  end


  # Process a job for the cluster
  #
  # @param jobs_array is a job object that will be processed
  def process_jobs ( jobs_array )

    update

    great_rating = 7
    good_rating = 14
    fair_rating = 21
    bad_rating = 22


    # Handles jobs at the beginning of our program
    if @machine_set.empty?
      machine_json = createNewMachine( @game_id )
      machine_obj = Machine.new(machine_json['id'] , machine_json['game_id'] , @length_of_game)
      @machine_set.push(machine_obj)

      # process all the jobs
      jobs_array.each do |job|

        if machine_obj.should_accept_more_jobs(job)
           machine_obj.add_to_machine(job)
        else
          machine_json_2 = createNewMachine( @game_id )
          machine_obj = Machine.new(machine_json_2['id'] , machine_json_2['game_id'] , @length_of_game)
          machine_obj.add_to_machine(job)
        end
      end



    end

    bad_jobs_array = []
    good_jobs_array = []

    # Separates the jobs by the job's rating
    jobs_array.each do |job|

      if job.rating <= good_rating
        good_jobs_array.push(job)
      else
        bad_jobs_array.push(job)
      end

    end

    # Sorts the array in descending order to get the really bad jobs first
    bad_jobs_array.sort_by { |job| job.rating}
    bad_jobs_array.reverse

    bad_jobs_index = 0
    # Tries to assign bad jobs to machines that can process
    # them immediately
    bad_jobs_array.each do |bad_job|

      @machine_set.each do |machine|

        if machine.memory_available > bad_job.memory ||
            machine.queue_empty && machine.memory_free_next_turn > bad_job.memory

          machine.add_to_machine( bad_job )
          bad_jobs_array.delete_at(bad_jobs_index)
          break

        end
      end

      bad_jobs_index += 1
    end


    good_job_index = 0
    # Adds as many good jobs to the machine as possible
    good_jobs_array.each do |good_job|

      @machine_set.each do |machine|

        if machine.should_accept_more_jobs
          machine.add_to_machine(good_job)
          good_jobs_array.delete_at(good_job_index)
          break
        end

      end

      good_job_index += 1
    end


    # If either are still running, then create a new machine
    # to process them and delete the machine when finished
    if good_jobs_array.empty? || bad_jobs_array.empty?

      new_machine_json = createNewMachine( @game_id )
      new_machine = Machine.new(new_machine_json['id'], new_machine_json['game_id'] , @length_of_game)


      # Processes the bad jobs first
      bad_jobs_array.each do |bad_job|
        new_machine.add_to_machine(bad_job)
      end

      # Processes all the good jobs
      good_jobs_array.each do |good_job|
        new_machine.add_to_machine(good_job)
      end

    end


  end





private

  # Finds the index of the 'best' machine to add the job to
  #
  # @return {int} index of the best machine to add the job to
  #         {nil} if no machines can add more jobs
  def state_of_machines
    return_array = Array.new

    @machine_set.each do |machine|
      hash = Hash.new
      hash['sum_of_turns'] = machine.average_turns_left
      hash['queue_rating'] = machine.average_rating_of_queue
      return_array.push(hash)
    end

    return_array
  end

  # # Creates a new machine. API ENDPOINT NEEDED
  # def createNewMachine
  #   #TODO
  # end
  #
  # # Removes a machine from the cluster. API ENDPOINT NEEDED
  # def removeMachine
  #   #TODO
  # end

  # Updates the cluster and all the data
  def update
    @machine_set.each do |machine|
      machine.update
    end
  end


  # Averages the ratings of a group of jobs
  #
  # @param job_array is the array of jobs
  # @return rating of the jobs
  def average_rating_of_jobs(job_array)
    size = job_array.count
    sum_of_rating = 0

    job_array.each do |job|
      sum_of_rating += job.rating
    end

    sum_of_rating / size
  end

end