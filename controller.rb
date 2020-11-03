require_relative 'recipe' # => model
require_relative 'view' # => view

class Controller
    def initialize(repository_name)
      # creates repository
      @view = View.new
      @repository = repository_name
    end
  
    def list
      # get list of recipes and send to view
      list = @repository.all
      # puts them to view
      @view.display(list)
    end
  
    def create
      # ask user for recipe and description
      name = @view.ask_name
      # make new recipe instance 
      recipe = Report.new({location: name})
      # put new recipe into repository
      @repository.add_recipe(recipe)
      
    end
  
    def destroy
      # show which do you want to
  
      # gets input from user
      recipe_index = @view.destroy
      # destroy index received
      @repository.remove_recipe(recipe_index)
    end
  
  end
