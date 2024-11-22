import pyodbc
import random

# Conexión a SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=CARLOS-LAPTOP\CARLOSSQL;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

# Obtener IDs válidos de la tabla 'person'
cursor.execute("SELECT id FROM person")
ids_person = [row[0] for row in cursor.fetchall()]

# Verificar si hay IDs disponibles
if not ids_person:
    print("No hay registros en la tabla 'person'. Inserción cancelada.")
else:
    # Insertar 100 registros
    for i in range(100):  # Ajustar el rango según sea necesario
        id_persona = random.choice(ids_person)
        cursor.execute("INSERT INTO flight_crew (id_person) VALUES (?)", (id_persona,))

    # Confirmar la inserción
    conn.commit()

    print("Datos insertados con éxito.")

# Cerrar cursor y conexión
cursor.close()
conn.close()
