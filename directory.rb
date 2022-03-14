def input_students
  puts "Please enter the names of the studnts"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the stedent hash to the array
    students << {
      name: name,
      cohort: :november,
      hobbies: "none given",
      country_of_birth: "not given",
      height: "not given"
    }
    puts "Now we have #{students.count} students"
    # get another name from user#
    name = gets.chomp
  end# return the array of students
  students
end
  
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]}, (#{student[:cohort]} cohort).
    Hobbies: #{student[:hobbies]},
    Country of birth: #{student[:country_of_birth]},
    Height: #{student[:height]}."
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
  
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)