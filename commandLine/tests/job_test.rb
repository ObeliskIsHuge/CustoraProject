require 'test/unit'
require_relative '../job'
class JobTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Tests the entire Job class
  def test_job

    id = 10
    turns = 6
    memory = 9

    test_job = Job.new(id , turns , memory)


    assert_equal(test_job.id , 10 , 'ids are not equal')
    assert_equal(test_job.turns_left, 6 , 'turns are not equal')
    assert_equal(test_job.memory , 9 , 'memory is not equal')

    test_job.update
    assert_equal(test_job.turns_left , 5 , 'update did not work')
    test_job.update
    assert_equal(test_job.turns_left , 4 , 'update did not work')
    test_job.update
    assert_equal(test_job.turns_left , 3 , 'update did not work')
    test_job.update
    assert_equal(test_job.turns_left , 2 , 'update did not work')
    test_job.update
    assert_equal(test_job.turns_left , 1 , 'update did not work')
    test_job.update
    assert_equal(test_job.turns_left , 0 , 'update did not work')
    test_job.update
    assert_equal(test_job.turns_left , 0 , 'update did not work')

  end
  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_fail

   # fail('Not implemented')
  end
end