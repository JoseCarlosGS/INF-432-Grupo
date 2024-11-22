import pyodbc
import random

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=CARLOS-LAPTOP\CARLOSSQL;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

#cursor.execute("TRUNCATE TABLE customer")
id_persona = 1
for i in range(20000):
    year = str(random.randint(1960, 2020))
    month = random.randint(1, 12)
    mes = f'{month:02d}'  
    
    if month in [4, 6, 9, 11]:  
        day = random.randint(1, 30)
    elif month == 2:  
        day = random.randint(1, 28)
    else:
        day = random.randint(1, 31)
    
    dia = f'{day:02d}'  
    id_persona = id_persona + random.randint(1, 3)
    fecha = f'{year}-{mes}-{dia}'
    cursor.execute("INSERT INTO customer (date_of_birth, id_person) VALUES (?, ?)", (fecha, id_persona))

conn.commit()

cursor.close()
conn.close()

print("Datos insertados con éxito.")