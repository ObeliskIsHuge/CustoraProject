require 'test/unit'
require_relative '../apiEndpoints'
# require 'commandLine/apiEndpoints'

class ApiEndpointsTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end


  # Tests the createNewGame method
  def test_api_end_points

    # tests the format of the key value array
    game = createNewGame('long')
    assert_equal(game['cost'] , 0 , 'cost does not equal zero')
    assert_equal(game['current_turn'] , 0 , 'turn does not equal zero')

    assert(!game['complete'] , 'game is complete')
    assert(!game['short'] ,'game is the short version')

    # tests to see that passing in 'short' returns a short game
    game2 = createNewGame('short')
    assert(game2['short'] , 'game is long')

    # Tests the getGameData method
    game_data = getGameData( game['id'] )
    assert_equal(game_data['id'] , game['id'] , 'game ids are not equal')
    assert_equal(game_data['cost'] , game['cost'] , 'costs are not equal')
    assert_equal(game_data['current_turn'] , game['current_turn'], 'turns are not equal')
    assert_equal(game_data['jobs_completed'] , game['jobs_completed'] , 'jobs completed are not equal')
    assert_equal(game_data['short'] , game['short'] , 'short is not equal')
    assert_equal(game_data['delay_turns'] , game['delay_turns'] , 'delay turns are not equal')

    # Test the new turn method
    game_turn = newTurn( game['id'] )

    game_jobs = game_turn['jobs']

    assert_equal(game_jobs[0]['turn'] , 1 , 'game_turn jobs are not equal')
    assert_equal(game_turn['status'] , 'active' , 'game is not active')
    assert_equal(game_turn['machines_running'] , 0 , 'there are machines running')
    assert_equal(game_turn['jobs_running'] , 0 , 'there are jobs running')
    assert_equal(game_turn['jobs_queued'] , 0 , 'there are jobs queued')


    # Tests the create new machine method
    machine_data = createNewMachine(game['id'])
    assert_equal(machine_data['terminated'] , nil , 'machine is not nil')


    # Tests the assign jobs method
    id_array = Array.new
    id_array.push(game_jobs[0]['id'])
    machine_jobs_data = assignJobs( game['id'] , machine_data['id'] , id_array)
    assert_equal(machine_jobs_data['queued'] , 0 , 'queued jobs is not correct')
    assert_equal(machine_jobs_data['running'] , 1 , 'running jobs is not one')

    # Tests the delete machine method
    deleted_machine = deleteMachine(game['id'] , machine_data['id'])
    assert_equal(deleted_machine['id'], machine_data['id'], 'deleted ids are not equal')
    assert_equal(deleted_machine['game_id'] , game['id'] , 'game ids are not equal')
    assert(deleted_machine['terminated'] , 'the machine was not terminated')

  end




  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_fail

#    assert(false, 'Assertion was false.')
  end
end