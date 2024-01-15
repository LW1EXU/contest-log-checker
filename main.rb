require_relative 'parsers'
require_relative 'database'
require_relative 'parse_qso'

file = "logs/N4BP.log"
content = File.read(file)

def parser(content)
    callsign = Parsers.parse_callsign(content)
    puts callsign

    category_operator = Parsers.parse_category_operator(content)
    puts category_operator
    
    category_assisted = Parsers.parse_category_assisted(content)
    puts category_assisted

    category_band = Parsers.parse_category_band(content)
    puts category_band

    category_power = Parsers.parse_category_power(content)
    puts category_power

    category_station = Parsers.parse_category_station(content)
    puts category_station

    category_transmitter = Parsers.parse_category_transmitter(content)
    puts category_transmitter
    
    if Parsers.errors.zero?
        puts "Cabrillo is all ok!"
    else
        puts "Cabrillo has errors"
        exit()
    end
    
    database_folder = "databases"
    db_name = "#{callsign}.db"
    db = Database.new(database_folder, db_name)
    db.process_content(content)

    qso_parser(content)

end

parser(content)


