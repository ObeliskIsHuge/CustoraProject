require 'test/unit'
require_relative '../machine'
class MachineTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Tests the entire machine class
  def test_machine

    id_1 = 1
    id_2 = 2
    game_id = 3
    game_length_1 = 'short'
    game_length_2 = 'long'

    machine_1 = Machine.new(id_1 , game_id , game_length_1)
    machine_2 = Machine.new(id_2 , game_id , game_length_2)

    # Tests to make sure that the game lengths are set correctly
    assert_equal(machine_1.max_queue_length , 40 , 'length is not correct')
    assert_equal(machine_2.max_queue_length , 80 , 'length is not correct')


    # Job stuff

    id = 10
    id_2 = 10
    turns = 2
    turns_2 = 6
    memory = 34
    memory_2 = 9

    test_job = Job.new(id , turns , memory)
    machine_1.add_to_machine(test_job)
    assert_equal(machine_1.memory_available, 30 , 'memory is not right')



  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_fail

#    fail('Not implemented')
  end
end