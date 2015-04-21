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
  def test_create_new_game

    # tests the format of the key value array
    game = createNewGame('long')
    assert_equal(game['cost'] , 0 , 'cost does not equal zero')
    assert_equal(game['current_turn'] , 0 , 'turn does not equal zero')

    assert(!game['complete'] , 'game is complete')
    assert(!game['short'] ,'game is the short version')

    # tests to see that the passing in 'short' returns a short game
    game2 = createNewGame('short')
    assert(game2['short'] , 'game is long')
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