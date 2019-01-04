# Seed para carregamento de Países, Estados e Cidades

puts 'Carregando Países, Estados e Cidades'
puts 'Zerando as tabelas'
City.delete_all
State.delete_all
Country.delete_all


puts 'Obtendo Países...'
countries_response = RestClient.get('https://raw.githubusercontent.com/alexishida/countries-states-cities-database-1/master/countries.json')
countries_response = JSON.parse(countries_response.body)
puts 'Inserindo Países...'
countries = []
countries_response.each do |country|
  puts "Inserindo #{country['name']}"
  countries << Country.new(id: country['id'], name: country['name'])
end
Country.import countries


puts 'Obtendo Estados...'
states_response = RestClient.get('https://raw.githubusercontent.com/alexishida/countries-states-cities-database-1/master/states.json')
states_response = JSON.parse(states_response.body)
puts 'Inserindo Estados...'
states = []
states_response.each do |state|
  puts "Inserindo #{state['name']}"
  states << State.new(id: state['id'], country_id: state['country_id'], name: state['name'])
end
State.import states


puts 'Obtendo Cidades...'
cities_response = RestClient.get('https://raw.githubusercontent.com/alexishida/countries-states-cities-database-1/master/cities.json')
cities_response = JSON.parse(cities_response.body)
puts 'Inserindo Cidades...'
cities = []
cities_response.each do |city|
  puts "Inserindo #{city['name']}"
  cities << City.new(id: city['id'], state_id: city['state_id'], name: city['name'])
end
City.import cities