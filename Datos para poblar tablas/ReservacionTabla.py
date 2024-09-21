import pyodbc
import random
import string

# Conexión a SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=HP\SQLEXPRESS;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

cursor.execute("TRUNCATE TABLE reservation")

def generar_codigo_reservacion():
    # Genera una parte alfanumérica de 4 caracteres
    parte1 = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))
    # Genera una parte alfanumérica de 4 caracteres
    parte2 = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))
    # Genera una parte alfanumérica de 4 caracteres
    parte3 = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))

    # Combina las partes con guiones
    codigo = f"{parte1}-{parte2}-{parte3}"
    return codigo

def codigo_unico(codigo):
    cursor.execute("SELECT COUNT(*) FROM reservation WHERE reservation_code = ?", (codigo,))
    return cursor.fetchone()[0] == 0  # Retorna True si el código es único

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
    id_customer = random.randint(1,20000)
    while True:
        nuevo_codigo = generar_codigo_reservacion()
        if codigo_unico(nuevo_codigo):
            cursor.execute("INSERT INTO reservation (reservation_code, reservation_date, id_payment, id_customer) VALUES (?, ?, ?, ?)", 
                   (nuevo_codigo,fecha,i+1,id_customer))
            

    # Confirmar la inserción
conn.commit()

# Cerrar cursor y conexión
cursor.close()
conn.close()

print("Datos insertados con éxito.")