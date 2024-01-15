require 'sqlite3'
require_relative 'parsers'
require_relative 'parse_qso'

class Database
    def initialize(folder, db_name)
        @db = SQLite3::Database.new(File.join(folder, db_name))
        create_table_if_not_exists
    end

    def create_table_if_not_exists
        @db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS variables (
            name TEXT PRIMARY KEY,
            value TEXT
        );
        SQL
    end

    def insert_variable(name, value)
        @db.execute("INSERT OR REPLACE INTO variables (name, value) VALUES (?, ?)", name, value)
    end

    def get_variable(name)
        result = @db.execute("SELECT value FROM variables WHERE name = ?", name)
        result.empty? ? nil : result[0][0]
    end

    def close
        @db.close
    end

    def process_content(content)
        callsign = Parsers.parse_callsign(content)
        db_name = "#{callsign}.db"

        create_table_if_not_exists
        insert_variable('CALLSIGN', callsign)
        insert_variable('CATEGORY_OPERATOR', Parsers.parse_category_operator(content))
        insert_variable('CATEGORY_ASSISTED', Parsers.parse_category_assisted(content))
        insert_variable('CATEGORY_BAND', Parsers.parse_category_band(content))
        insert_variable('CATEGORY_MODE', Parsers.parse_category_mode(content))
        insert_variable('CATEGORY_POWER', Parsers.parse_category_power(content))
        insert_variable('CATEGORY_STATION', Parsers.parse_category_station(content))
        insert_variable('CATEGORY_TRANSMITTER', Parsers.parse_category_transmitter(content))


        qso_parser(content).each do |qso|
            insert_variable('FREQUENCY', qso[:frequency])
            insert_variable('MODE', qso[:mode])
            insert_variable('DATE', qso[:date])
            insert_variable('TIME', qso[:time])
            insert_variable('CALLSIGN1', qso[:callsign1])
            insert_variable('SIGNAL1', qso[:signal1])
            insert_variable('EXCHANGE1', qso[:exchange1])
            insert_variable('CALLSIGN2', qso[:callsign2])
            insert_variable('SIGNAL2', qso[:signal2])
            insert_variable('EXCHANGE2', qso[:exchange2])
        end
        close
    end
end
