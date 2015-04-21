# File handles the api endpoint calls
#
#

require 'rubygems'
require 'bundler/setup'
require 'json'
require 'rest-client'

# host = 'http://job-queue-dev.elasticbeanstalk.com'

# Creates a new Instance of the game
#
# @param version is the version of the game that will be played.
# 'long' if the version is the long version, short version otherwise
# @return key-value array of the new game
def createNewGame (version)

  host = 'http://job-queue-dev.elasticbeanstalk.com'

  # creates a long game when true
  if version == 'long'
    game_json = RestClient.post(
        "#{host}/games",
        { long: true }
    ).body
  else
    game_json = RestClient.post(
        "#{host}/games",
        {}
    ).body
  end

 JSON.parse(game_json)
end


# Gets info data of the game
#
# @param game_id is the id of the game
# @return key-value array with game information
def getGameData( game_id )

  # host = 'http://job-queue-dev.elasticbeanstalk.com'

  info_json = RestClient.post("http://job-queue-dev.elasticbeanstalk.com/games/#{game_id}",
                              {}).body

  JSON.parse(info_json)
end


# Creates a new machine
#
# @param game_id is the id of the game
# @return key-value array of the new machine data
def createNewMachine ( game_id )

  host = 'http://job-queue-dev.elasticbeanstalk.com'


  machine_json = RestClient.post(
      "#{host}/games/#{game_id}/machines",
      {}
  ).body

  JSON.parse(machine_json)
end


# Moves to the next turn
#
# @param game_id is the id of the game
# @return key-value array of the new turn data
def newTurn ( game_id )

  host = 'http://job-queue-dev.elasticbeanstalk.com'

  turn_json = RestClient.get(
      "#{host}/games/#{game_id}/next_turn"
  ).body
  JSON.parse(turn_json)
end


# Deletes a machine
#
# @param game_id is the id of the game
# @param machine_id is the id of the machine that will be deleted
# @return key-value array of machine running data
def deleteMachine ( game_id , machine_id)

  host = 'http://job-queue-dev.elasticbeanstalk.com'

  RestClient.delete("#{host}/games/#{game_id}/machines/#{machine_id}")
  machine_json = RestClient.post("#{host}/games/#{game_id}/machines", {}).body
  JSON.parse(machine_json)
end

# Assigns jobs to a machine
#
# @param game_id is the id of the game
# @param machine_id is the id of the machine
# @param job_ids is the id of the jobs
# @return key-value array assigned jobs to the machine
def assignJobs ( game_id , machine_id , job_ids)

  host = 'http://job-queue-dev.elasticbeanstalk.com'

  RestClient.post(
      "#{host}/games/#{game_id}/machines/#{machine_id}/job_assignments",
      job_ids: JSON.dump(job_ids)
  ).body
end