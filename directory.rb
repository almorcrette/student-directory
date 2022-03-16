# Input student

def input_students
  # Initialize students array
  students = []
  
  # Receive preference to enter a new student or not
  puts "Enter new student? 1 for yes, 0 for no"
  new_entry = gets.chomp
  
  # Loop process for entering new students until user states no more
  while new_entry != "0" do
    
    # Receive surname
    puts "Enter surname:"
    surname = gets.chomp
    
    # Receive first name
    puts "Enter First name:"
    first_name = gets.chomp
    
    # Start again if either field is empty
    if surname == "" || first_name == ""
      puts "Invalid entry. Fields must be non-empty. Try again"
      next
    end
    
    # Receive cohort, via loop until valid entry for cohort given
    cohort = "not given"
    until cohort != "not given"
      puts "Enter cohort: (november, december, january, february)"
      cohort = gets.chomp
      cohort = "not given" if cohort != "november" && cohort != "december" && cohort != "january" && cohort != "february"
      puts "Invalid entry for cohort. Try again."
    end
    cohort = cohort.to_sym
    
    # Option to re-enter for typos
    puts "Sure you want to enter: #{first_name} #{surname}, cohort #{cohort}? 1 for yes. 0 for re-enter. x for finish"
    selection = gets.chomp
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
    
    # Receive preference for another entry
    puts "Another entry? 1 for yes, 0 for no"
    new_entry = gets.chomp
  
  end# return the array of students
  
  students
  
end
  
def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

def print(students, letter)
  students.each_with_index do |student, index|
    if student[:name].chr.downcase == letter.downcase and student[:name].length < 12
      puts "#{index + 1}. #{student[:name]}, (#{student[:cohort]} cohort)
Hobbies: #{student[:hobbies]},
Country of birth: #{student[:country_of_birth]},
Height: #{student[:height]}."
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(100)
end
  
# nothing happens until we call the methods
students = input_students
print_header
print(students, "A")
print_footer(students)