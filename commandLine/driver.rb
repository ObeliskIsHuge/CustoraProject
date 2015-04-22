# File represents the driver for the entire program
#

require_relative 'cluster'
require_relative 'apiEndpoints'
require_relative 'job'

input_needed = true
game_length = ''
puts 'Welcome to the Job Queue Project!'

# Keeps running until we've received an appropriate input
while input_needed

  puts 'Long version, type: "l". Short version, type: "s"'

  user_input = gets.chomp

  # short version of the game
  if user_input == 's'
    game_length = 'short'
    input_needed = false

  # long version of the game
  elsif user_input == 'l'
    game_length = 'long'
    input_needed = false

  # error
  else
    puts 'Invalid input. Please try again'
  end
end

# creates new game
new_game_json = createNewGame(game_length)

game_id = new_game_json['id']
cluster = Cluster.new(game_id , game_length)
game_status = 'not completed'

# Keeps running until the game is finished
while game_status != 'completed'

  turn_json = newTurn ( game_id )

  # TODO this may need to change
  puts "On turn #{turn_json['current_turn']}, got #{turn_json['jobs'].count} jobs, having
  completed #{turn_json['jobs_completed']} of #{turn_json['jobs'].count} with #{turn_json['jobs_running']}
  jobs running, #{turn_json['jobs_queued']} jobs queued, and
  #{turn_json['machines_running']} machines running"


  jobs_json = turn_json['jobs']

  # takes the jobs_json and processes each job individually
  jobs_json.each { |x|
    job = Job.new( x['id'] , x['turns_required'], x['memory_required'])
    cluster.processJob( job )
  }

end


final_json = getGameData( game_id )
puts final_json
puts "\n\n"


puts 'COMPLETED GAME WITH:'
puts "Total delay: #{final_json['delay_turns']} turns"
puts "Total cost: $#{final_json['cost']}"



