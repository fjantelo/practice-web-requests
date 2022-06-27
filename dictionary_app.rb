require "http"

api = "API KEY GOES HERE"

system "clear"

while true
  puts "Enter a word that you want defined. Enter 'q' to quit."
  word = gets.chomp.downcase

  if word == "q"
    break
  else
    response = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=#{api}")

    example_response = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/examples?includeDuplicates=false&useCanonical=false&limit=5&api_key=#{api}")

    pronunciation = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/pronunciations?useCanonical=false&limit=50&api_key=#{api}")

    audio = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/audio?useCanonical=false&limit=50&api_key=#{api}")

    puts ""
    puts "Here is the definition:"
    puts response.parse(:json)[0]["text"]
    puts ""
    puts "Here is an example:"
    puts example_response.parse(:json)["examples"][0]["text"]
    puts ""
    puts "Here is the pronunciation:"
    puts pronunciation.parse(:json)[0]["raw"]
    puts ""
    system("open", audio.parse(:json)[0]["fileUrl"])
  end
end
