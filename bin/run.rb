

require_relative '../config/environment'
require 'JSON'
require 'rest-client'
require 'pry'
require 'uri'
require 'net/http'
require 'rubygems'
require 'colorize'
# require 'httparty'

# USER LOGIN EXAMPLE:
# puts "Welcome, please enter a username to sign-up or login:"
# input = gets.chomp
# @current_user = User.find_or_create_by(username: input)
# MOVIE SEARCH EXAMPLE:
# puts "Please search for a movie title:"
# title = gets.chomp
# movie_data = RestClient.get("http://www.omdbapi.com/?t=#{title}&apikey=5452b626")
# parse = JSON.parse(movie_data)
# EXAMPLE OF SAVING A MOVIE:
# puts "do you want to save this movie?"
# response = gets.chomp
# if response = "y"
#   movie = Movie.find_or_create_by(title: parse["Title"], plot: parse.plot)
#   UserMovie.find_or_create_by(user_id: @current_user.id, movie_id: movie.id)
#answer=gets.chomp
# attr_accessor :user

movie_data = RestClient.get("http://www.omdbapi.com/?i=tt3896198&apikey=5452b626")
parse = JSON.parse(movie_data)
# invalid_answer = "Sorry, invalid data. Try again!"





def greet
  puts "*******************************".red
  puts '          WELCOME!!!!   '.blue.blink
  puts '  to FAVORITE MOVIE NOTEPAD!'.blue.blink
  puts '*******************************'.red
  puts 'Hi there!!!!'
  puts "Please, enter a username to sign-up or login: "
  input = gets.chomp
  current_user = User.find_or_create_by(user: input)
  # puts "#{@current_user.user}, what would you like to do?"
  # choice = gets.chomp.to_i
  puts " **************************************************".cyan
  puts " **************************************************".cyan
  puts " ***                MENU                        ***".red
  puts " *** 1. Search your favorite movie!             ***".red
  puts " *** 2. Save to your list?!?! y / n             ***".red
  puts " *** 3. Show the whole list!!!!!Yay!            ***".red
  puts " *** 4. Delete a show from your list?           ***".red
  puts " *** 5. Update your Username                    ***".red
  puts " *** 6. Exit                                    ***".red
  puts " **************************************************".cyan
  puts " **************************************************".cyan


  puts "#{current_user.user}, what would you like to do?"
  choice = gets.chomp.to_i

  while choice < 7
    puts " **************************************************".cyan
    puts " **************************************************".cyan
    puts " ***                MENU                        ***".red
    puts " *** 1. Search your favorite movie!             ***".red
    puts " *** 2. Save to your list?!?! y / n             ***".red
    puts " *** 3. Show the whole list!!!!!Yay!            ***".red
    puts " *** 4. Delete a show from your list?           ***".red
    puts " *** 5. Update your Username                    ***".red
    puts " *** 6. Exit                                    ***".red
    puts " **************************************************".cyan
    puts " **************************************************".cyan
    # t.string :title
    # t.integer :year
    # t.string :genre
    # t.string :plot
    # t.string :runtime
    # puts "#{@current_user.user}, what would you like to do?"
    # choice = gets.chomp.to_i
    # while choice < 5
    case choice

    when 1

      puts "Great!!!! #{current_user.user}, enter the title here "
      title_input = gets.chomp
      searchedMovie = RestClient.get("http://www.omdbapi.com/?i=tt3896198&apikey=5452b626&t=#{title_input}")
      json_movie = JSON.parse(searchedMovie)
      movie1 = Movie.find_or_create_by(title: json_movie["Title"], year: json_movie["Year"], genre: json_movie["Genre"], plot: json_movie["Plot"], runtime: json_movie["Runtime"] )
      puts "PLOT of this movie is ...#{json_movie["Plot"]}. THE YEAR is #{json_movie["Year"]}. THE GENRE: #{json_movie["Genre"]}. And, it will take #{json_movie["Runtime"]} out of your life. )))"

      puts "What would you like to do next #{current_user.user} ?"
      choice = gets.chomp.to_i

    when 2

      puts "You are about to save this movie to your list. Y/N ?"
      #write a method to get the input from the user (gets.chomp)
      save_input = gets.chomp
      case save_input
        when save_input = "Y"
          new_movie = UserMovie.find_or_create_by(user_id: current_user.id, movie_id: movie1.id)
          # Movie.push(new_movie)
          # movie_id = @movie_name
          puts "Added!!! Yay!!!"
        when save_input = "N"
        puts "Okay! Come back when you are ready )))"
      end
        puts "What would you like to do next #{current_user.user} ?"
        choice = gets.chomp.to_i


    when 3
      # binding.pry
      puts "Here is the list of your Favorite movies: "
      # Movie.find_or_create_by("#{title_input}")
      UserMovie.where(user_id: current_user.id).each_with_index do|usermovie, index|
        movie = Movie.find(usermovie.movie_id)
        # movie_name+ = "#{title_input}"
        puts "#{index + 1}. #{movie.title}"
      end
      puts "What would you like to do next #{current_user.user} ?"
      choice = gets.chomp.to_i

    when 4

      puts "Let's delete it from your list."
      puts "Enter the Title of the movie you want to delete from Movie Notepad"
      delete_choice = gets.chomp
      # binding.pry
      # UserMovie.where(user_id: current_user.id).each_with_index do |usermovie, index|

      user_movie_to_delete = Movie.find_by(title: delete_choice)

      another_um = UserMovie.find_by(user_id: current_user.id,  movie_id: user_movie_to_delete.id)
      another_um.destroy
      # end
      # user_movie_to_delete.delete
      puts "DELETED!!!"
      puts "What would you like to do next #{current_user.user} ?"
      choice = gets.chomp.to_i

    when 5
      # binding.pry
      puts "Enter your new username"
      new_user = gets.chomp
      current_user.update(user: "#{new_user}")
      puts "Yay!!!"



    puts "What would you like to do next #{current_user.user} ?"
    choice = gets.chomp.to_i

    when 6

      puts "Bye, bye. See you soon!"
      break


    end
  end
end
greet
