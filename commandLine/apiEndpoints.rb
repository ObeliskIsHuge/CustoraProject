
host = 'http://job-queue-dev.elasticbeanstalk.com'

# Creates a new Instance of the game

def createNewGame (version)

  if version.equal? 'l'
    type = true
  else
    type = false
  end
  game_json = RestClient.post(
      "#{host}/games",
      {},
   { long: type }
  ).body

  game = JSON.parse(game_json)

  return game

end



def createNewMachine
  machine_json = RestClient.post(
      "#{host}/games/#{game['id']}/machines",
      {}
  ).body
  machine = JSON.parse(machine_json)

  return machine


end