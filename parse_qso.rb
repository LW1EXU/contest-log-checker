def qso_parser(content)
    qso_data = []
  
    log_lines = content.strip.split("\n")
  
    qso_started = false  # Flag to check if QSO section has started
  
    log_lines.each do |line|
      if line.start_with?("QSO:")
        qso_started = true  # Set the flag to indicate the start of QSO section
        next  # Skip the line as it has already been processed
      end
  
      # Process QSO lines only if the QSO section has started
      if qso_started
        qso_parts = line.split
  
        qso = {
          frequency: qso_parts[0],
          mode: qso_parts[1],
          date: qso_parts[2],
          time: qso_parts[3],
          callsign1: qso_parts[4],
          signal1: qso_parts[5],
          exchange1: qso_parts[6],
          callsign2: qso_parts[7],
          signal2: qso_parts[8],
          exchange2: qso_parts[9]
        }
  
        qso_data << qso
      end
    end
  
    qso_data
  end
  