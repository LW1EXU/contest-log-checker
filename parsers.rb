require_relative 'definitions'
require_relative 'database'

class Parsers
    @errors = 0

    def self.errors
        @errors
    end

    def self.parse_callsign(content)
        match = content.match(/CALLSIGN:\s*([^\s]+)/)
        match[1]
    end

    def self.parse_category_operator(content)
        match = content.match(/CATEGORY-OPERATOR:\s*([^\s]+)/)
        category_operator = match[1]
        unless Definitions::CATEGORY_OPERATOR.include?(category_operator)
            @errors += 1
            category_operator += "!"
        end
        category_operator
    end

    def self.parse_category_assisted(content)
        match = content.match(/CATEGORY-ASSISTED:\s*([^\s]+)/)
        category_assisted = match[1]
        unless Definitions::CATEGORY_ASSISTED.include?(category_assisted)
            @errors += 1
            category_assisted += "!"
        end
        category_assisted
    end

    def self.parse_category_band(content)
        match = content.match(/CATEGORY-BAND:\s*([^\s]+)/)
        category_band = match[1]
        unless Definitions::CATEGORY_BAND.include?(category_band)
            @errors += 1
            category_band += "!"
        end
        category_band
    end

    def self.parse_category_mode(content)
        match = content.match(/CATEGORY-MODE:\s*([^\s]+)/)
        category_mode = match[1]
        unless Definitions::CATEGORY_MODE.include?(category_mode)
            @errors += 1
            category_mode += "!"
        end
        category_mode
    end

    def self.parse_category_power(content)
        match = content.match(/CATEGORY-POWER:\s*([^\s]+)/)
        category_power = match[1]
        unless Definitions::CATEGORY_POWER.include?(category_power)
            @errors += 1
            category_power += "!"
        end
        category_power
    end

    def self.parse_category_station(content)
        match = content.match(/CATEGORY-STATION:\s*([^\s]+)/)
        category_station = match[1]
        unless Definitions::CATEGORY_STATION.include?(category_station)
            @errors += 1
            category_station += "!"
        end
        category_station
    end

    def self.parse_category_transmitter(content)
        match = content.match(/CATEGORY-TRANSMITTER:\s*([^\s]+)/)
        category_transmitter = match[1]
        unless Definitions::CATEGORY_TRANSMITTER.include?(category_transmitter)
            @errors += 1
            category_transmitter += "!"
        end
        category_transmitter
    end
end
    
    