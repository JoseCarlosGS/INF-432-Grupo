import pyodbc
import random

# Conexión a SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=HP\SQLEXPRESS;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

# Eliminar los datos de la tabla y reiniciar el contador de identidad
#cursor.execute("TRUNCATE TABLE customer")
id_persona = 1
for i in range(20000):
    year = str(random.randint(1960, 2020))
    # Mes entre 1 y 12
    month = random.randint(1, 12)
    mes = f'{month:02d}'  # Asegura que siempre sea de dos dígitos
    
    if month in [4, 6, 9, 11]:  # Abril, Junio, Septiembre, Noviembre tienen 30 días
        day = random.randint(1, 30)
    elif month == 2:  # Febrero tiene 28 días (sin años bisiestos por simplicidad)
        day = random.randint(1, 28)
    else:
        day = random.randint(1, 31)
    
    dia = f'{day:02d}'  # Asegura que siempre sea de dos dígitos
    id_persona = id_persona + random.randint(1, 3)
    # Fecha en formato correcto
    fecha = f'{year}-{mes}-{dia}'
    cursor.execute("INSERT INTO customer (date_of_birth, id_person) VALUES (?, ?)", (fecha, id_persona))

# Confirmar la inserción
conn.commit()

# Cerrar cursor y conexión
cursor.close()
conn.close()

print("Datos insertados con éxito.")