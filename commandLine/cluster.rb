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


    # Tries to assign bad jobs to machines that can process
    # them immediately
    bad_jobs_array.each do |bad_job|

      @machine_set.each do |machine|

        if machine.memory_available > bad_job.memory ||
            machine.queue_empty && machine.memory_free_next_turn > bad_job.memory

          machine.add_to_machine( bad_job )
          break

        end
      end
    end


    # Adds as many jobs to the machine as possible
    good_jobs_array.each do |good_job|

      @machine_set.each do |machine|

      end
    end








    # bad_machine_count = 0
    # # Counts the amount of bad machines
    # @machine_set.each do |machine|
    #   if machine.memory_available <= 10 && machine.average_rating_of_queue > fair_rating
    #     bad_machine_count += 1
    #   end
    #
    # end
    #
    # # Will be true when most of the machines are busy
    # if bad_machine_count >= .75 * @machine_set.count
    #
    #   machine_json = createNewMachine( @game_id )
    #   machine_obj = Machine.new(machine_json['id'] , machine_json['game_id'] , @length_of_game)
    #
    #   jobs_array.each do |job|
    #     machine_obj.add_to_machine(job)
    #   end
    # #TODO figure out how to handle this
    # else
    #
    #   rating = average_rating_of_jobs( jobs_array )
    #   machines_state = state_of_machines
    #
    #   jobs_array.each do |job|
    #
    #     machine_needed = true
    #
    #     while machine_needed
    #
    #       @machine_set.each do |machine|
    #         # machine.
    #       end
    #     end
    #
    #   end
    #
    #
    #
    #
    # end

    cluster_clean_up
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


  # 'Cleans Up' the cluster. IE. Reallocate jobs as necessary and
  # deletes machines that are no longer needed
  def cluster_clean_up
    #TODO
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