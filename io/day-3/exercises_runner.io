writeln("Book examples")
writeln
writeln("Xml builder")
writeln("Given the following instructions:")
File open("./io/day-3/xml.example") contents println
writeln("Then the xml builder writes:")
doFile("./io/day-3/xml.exercise")

writeln
writeln("JSON hash")
writeln("Given the following json:")
File open("./io/day-3/phonebook.example") contents println
writeln("Then Io creates a hash with:")
doFile("./io/day-3/phonebook.exercise")

writeln("Exercises")
writeln
writeln("Enhance the XML program to add spaces to show the indentation structure")
writeln("Given the following instructions:")
File open("./io/day-3/xml.example") contents println
writeln("Then the enhanced xml builder writes:")
doFile("./io/day-3/formatted_xml.exercise")

writeln
writeln("Create a list syntax using brackets")
writeln("Given the following instructions:")
File open("./io/day-3/list_with_brackets.example") contents println
writeln("Then Io creates the following list:")
doFile("./io/day-3/list_with_brackets.exercise")

writeln
writeln("Enhance the XML program to handle attributes")
writeln("Given the following instructions:")
File open("./io/day-3/xml_with_attributes.example") contents println
writeln("Then the enhanced xml builder writes:")
doFile("./io/day-3/xml_with_attributes.exercise")

