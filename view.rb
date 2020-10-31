class View
    def ask_name
      puts " what is recipe name?"
      p "> "
      return gets.chomp
    end
  
    def ask_description 
      puts "what is descriptioon"
      p "> "
      return gets.chomp
    end
  
    def display(item)
      puts item
    end
  
    def destroy
      puts "what index do you want to delete?"
      p "> "
      return gets.chomp
    end
  end
  