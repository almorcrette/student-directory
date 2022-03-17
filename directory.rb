# Initiate instance variable students, the array that holds the directoy
@students = []

# Start message
def start_message
  puts "\n" + "Welcome to the Villains Academy Student Directory\n".center(100)
end

# Add student

def add_student(name, cohort)
  @students << {
    name: name,
    cohort: cohort.to_sym,
    hobbies: "none given",
    country_of_birth: "not given",
    height: "not given"
  }
end

## Input student methods
# - INPUT_STUDENTS, calling: 
#   - CHECK_INSTRUCTION_NEW_ENTRY
#   - NAME_ENTRY
#   - COHORT_ENTRY
#   - CONFIRM_ENTRY
#   - MORE?

# CHECK_INSTRUCTION_NEW_ENTRY: Confirming instruction to enter new student
# While loop with break prevents invalid entry (not 1 or 0)
# Demonstrating alternative to chomp

def check_instruction_new_entry
  while true do
    puts "Enter new student? 1 for yes, 0 for no"
    new_entry = STDIN.gets.delete_suffix("\n")
    break if new_entry == "0" || new_entry == "1"
  end
  new_entry
end

# NAME_ENTRY:
# - Receive surname and first name,
# - confirm valid,
# - join

def name_entry
  surname = ""
  first_name = ""
  loop do
    puts "Enter surname:"
    surname = STDIN.gets.chomp
    puts "Enter First name:"
    first_name = STDIN.gets.chomp
    if surname == "" || first_name == ""
      puts "Invalid entry. Name fields must be non-empty. Try again"
    else
      break
    end
  end
  name = first_name + " " + surname
end

# COHORT_ENTRY:
# - Receive cohort information,
# - via loop until valid entry for cohort given

def cohort_entry
  cohort = "not given"
  until cohort != "not given"
    puts "Enter cohort: (november, december, january, february)"
    cohort = STDIN.gets.chomp
    if cohort != "november" &&
       cohort != "december" &&
       cohort != "january" &&
       cohort != "february"
      cohort = "not given" 
      puts "Invalid entry for cohort. Try again."
    end
  end
  cohort
end

# CONFIRM_ENTRY
# - including option to re-enter for typos,
# - including while loop with break for invalid entry

def confirm_entry(name, cohort)
  while true
    puts "Sure you want to enter: #{name}, cohort #{cohort.capitalize}?
1 for yes. 0 for re-enter. x to exit without saving"
    selection = STDIN.gets.chomp
    break if ["0", "1", "x"].include?(selection) 
  end
  selection
end
  
# MORE?
# - Receive preference for another entry,
# - including while loop with break to repeat until valid entry (1, 0)

def more?
  while true do
    puts "Another entry? 1 for yes, 0 for no"
    new_entry = STDIN.gets.chomp
    break if new_entry == "0" || new_entry == "1"
  end
  new_entry
end
  
# INPUT_STUDENTS:
# - Confirm instruction to for new entry
# - name_entry

def input_students
  new_entry = check_instruction_new_entry
  while new_entry != "0" do
    name = name_entry
    cohort = cohort_entry
    selection = confirm_entry(name, cohort)
    case selection
    when "0" # user wants to re-enter (typo)
      next
    when "x" # user wants to exit without saving
      break
    end
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
    new_entry = more? # Will return "0" if no more entries
  end
end

# Header printer

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

# Print students starting with a particular letter

def print_section(letter)
  @students.each_with_index do |student, index|
    if student[:name].chr.downcase == letter.downcase and student[:name].length < 12
      puts "#{index + 1}. #{student[:name]}, (#{student[:cohort]} cohort)
Hobbies: #{student[:hobbies]},
Country of birth: #{student[:country_of_birth]},
Height: #{student[:height]}."
    end
  end
end

# Print students by cohorts

def print_student_list_by_cohorts
  cohorts = @students.map { |student| student[:cohort] }.uniq
  cohorts.each do |cohort|
    puts "#{cohort.capitalize}:"
    @students.each { |student| puts student[:name] if student[:cohort] == cohort }
  end
end

# Print footer

def print_footer
  puts @students.count == 1 ? 
  "Now we have 1 student".center(100) :
  "Overall, we have #{@students.count} great students".center(100)
end

## Interactive menu methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  if @students.count == 0
    puts "No students in directory"
  else
    print_header
    print_student_list_by_cohorts
    print_footer
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2" # show the students
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

## Interactive menu
# 1. print the menu and ask the user what to do
# 2. read the input and save it into a variable
# 3. do what the user has asked
# 4. repeat from step 1

def interactive_menu
  loop do
    print_menu 
    selection = STDIN.gets.chomp  
    process(selection)
  end
end

## Saving directory to file
# open the file for writing
# iterate over the array of students

def save_students
  puts "Saving directory..."
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Directory saved!"
end

## Loading the data

# Loading the data
 
def load_students(filename = "students.csv")
  puts "Loading directory..."
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student(name, cohort)
  end
  file.close
  puts "Directory loaded!"
end

# Try loading the data from argument when program run

def try_load_students
  # load "students.csv" by default or first agrument given in command line.
  ARGV.first.nil? ? filename = "students.csv" : filename = ARGV.first
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

## Execute program

try_load_students
start_message
interactive_menu
