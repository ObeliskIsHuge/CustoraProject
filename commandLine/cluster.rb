# Class represents a Cluster object
#
# "Clusters" is a group of a machine objects

require 'machine'
require 'job'

class Cluster

  # Creates a getter for machine_set
  attr_reader :machine_set

  # Creates a new Cluster object
  #
  # length will be be true when we're playing the short version
  # length will be false otherwise
  def initialize ( length )
    @machine_set = []
    @short = length
  end



  def processTurn ( job_data , status_data)

    new_job = Job.new(job_data['id'] , job_data['turns_required'] , job_data['memory_required'])


  end






end