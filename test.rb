require_relative 'database'

def obtener_callsign(ruta_directorio, nombre_base_datos)
  db = Database.new(ruta_directorio, nombre_base_datos)
  callsign = db.get_variable('CALLSIGN')
  db.close
  callsign
end

# Ejemplo de uso:
ruta_directorio = 'ruta_del_directorio'
nombre_base_datos = 'nombre_de_la_base_de_datos.db'

callsign = obtener_callsign(ruta_directorio, nombre_base_datos)
puts "El callsign almacenado en la base de datos es: #{callsign}"
