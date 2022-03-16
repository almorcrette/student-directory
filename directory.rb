## Methods
## This program has the following methods
## - Start message
## - Interactive menu
## - Input students
## - Print header
## - Print footer
## - Print sections of students by starting name letter
## - Print students by cohorts

# Start message
def start_message
  puts "\n" + "Welcome to the Villains Academy Student Directory".center(100)
end

# Interactive menu
def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
      when "1"
        students = input_students
      when "2" # show the students
        if students.count == 0
          puts "No students in directory"
        else
          print_header
          print_cohorts(students)
          print_footer(students)
        end
      when "9"
        exit # this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
    end
  # 4. repeat from step 1
  end
end

# Input student

def input_students
  
  # Initiate an empty array to receive new student information
  students = []

  # Receive preference to enter a new student or not
  # While loop with break prevents invalid entry (not 1 or 0)
  while true do
    puts "Enter new student? 1 for yes, 0 for no"
    # Demonstrating alternative to chomp
    new_entry = gets.delete_suffix("\n")
    break if new_entry == "0" || new_entry == "1"
  end
  
  # Loop process for entering new students until user states no more new entries
  while new_entry != "0" do
    
    # Receive surname
    puts "Enter surname:"
    surname = gets.chomp
    
    # Receive first name
    puts "Enter First name:"
    first_name = gets.chomp
    
    # Start again if either field is empty
    if surname == "" || first_name == ""
      puts "Invalid entry. Name fields must be non-empty. Try again"
      next
    end
    
    # Receive cohort information, via loop until valid entry for cohort given
    cohort = "not given"
    until cohort != "not given"
      puts "Enter cohort: (november, december, january, february)"
      cohort = gets.chomp
      if cohort != "november" &&
         cohort != "december" &&
         cohort != "january" &&
         cohort != "february"
        cohort = "not given" 
        puts "Invalid entry for cohort. Try again."
      end
    end
    cohort = cohort.to_sym
    
    # Option to re-enter for typos,
    #including while loop with break for invalid entry
    while true
      puts "Sure you want to enter: #{first_name} #{surname}, cohort #{cohort.capitalize}?
1 for yes. 0 for re-enter. x to exit without saving"
      selection = gets.chomp
      break if ["0", "1", "x"].include?(selection) 
    end
    case selection
    when "0"
      next
    when "x"
      break
    end
      
    # Add entry to array
    students << {
        name: "#{first_name} #{surname}",
        cohort: cohort,
        hobbies: "none given",
        country_of_birth: "not given",
        height: "not given"
      }
    
    puts "Now we have #{students.count} students"
    
    # Receive preference for another entry,
    #including while loop with break to repeat until valid entry (1, 0)
    while true do
      puts "Another entry? 1 for yes, 0 for no"
      new_entry = gets.chomp
      break if new_entry == "0" || new_entry == "1"
    end
  
  end # return the array of students
  
  students
  
end

# Header printer

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

# Print students starting with a particular letter

def print_section(students, letter)
  students.each_with_index do |student, index|
    if student[:name].chr.downcase == letter.downcase and student[:name].length < 12
      puts "#{index + 1}. #{student[:name]}, (#{student[:cohort]} cohort)
Hobbies: #{student[:hobbies]},
Country of birth: #{student[:country_of_birth]},
Height: #{student[:height]}."
    end
  end
end

# Print footer

def print_footer(students)
  puts students.count == 1 ? 
  "Now we have 1 student".center(100) :
  "Overall, we have #{students.count} great students".center(100)
end

# Print students by cohorts

def print_cohorts(students)
  cohorts = students.map { |student| student[:cohort] }.uniq
  cohorts.each do |cohort|
    puts "#{cohort.capitalize}:"
    students.each { |student| puts student[:name] if student[:cohort] == cohort }
  end
end

puts start_message
interactive_menu
if students.count == 0
  puts "No students in directory"
else
  print_header
#print_section(students, "A")
  print_cohorts(students)
  print_footer(students)
end