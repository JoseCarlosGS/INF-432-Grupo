import pyodbc
import random

# Conexión a SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=HP\SQLEXPRESS;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

min_value = 10.00
max_value = 5000.00

cursor.execute("TRUNCATE TABLE payment")

def fecha_random(min_year, max_year):
    year = str(random.randint(min_year, max_year))
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
    # Fecha en formato correcto
    fecha = f'{year}-{mes}-{dia}'
    return fecha

for i in range(80000):
 # Asegura que siempre sea de dos dígitos
    fecha = fecha_random(2020,2024)
    random_decimal = random.uniform(min_value, max_value)
    monto = round(random_decimal, 2)
    cursor.execute("INSERT INTO payment (amount, date_of_pay, id_payment_method) VALUES (?, ?, ?)", (monto,fecha,i))

    # Confirmar la inserción
conn.commit()

# Cerrar cursor y conexión
cursor.close()
conn.close()

print("Datos insertados con éxito.")