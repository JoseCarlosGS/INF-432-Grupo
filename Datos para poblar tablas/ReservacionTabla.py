import pyodbc
import random
import string

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=HP\SQLEXPRESS;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

cursor.execute("TRUNCATE TABLE reservation")

def generar_codigo_reservacion():
    parte1 = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))  
    parte2 = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))
    parte3 = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))

    codigo = f"{parte1}-{parte2}-{parte3}"
    return codigo

codigos_generados = set()
num_inserciones = 80000
data_to_insert = []

def fecha_random(min_year, max_year):
    year = str(random.randint(min_year, max_year))
    month = random.randint(1, 12)
    mes = f'{month:02d}'  
    
    if month in [4, 6, 9, 11]:  
        day = random.randint(1, 30)
    elif month == 2:  
        day = random.randint(1, 28)
    else:
        day = random.randint(1, 31)
    
    dia = f'{day:02d}'
    fecha = f'{year}-{mes}-{dia}'
    return fecha

for i in range(80000):
    fecha = fecha_random(2020,2024)
    id_customer = random.randint(1,20000)
    while True:
        codigo = generar_codigo_reservacion()
        if codigo not in codigos_generados:
            codigos_generados.add(codigo)
            break
    data_to_insert.append((codigo, fecha, i+1, id_customer))
    
batch_size = 1000  
for i in range(0, len(data_to_insert), batch_size):
    batch = data_to_insert[i:i + batch_size]
    cursor.executemany("INSERT INTO reservation (reservation_code, reservation_date, id_payment, id_customer) VALUES (?, ?, ?, ?)", batch)
    
#cursor.execute("INSERT INTO reservation (reservation_code, reservation_date, id_payment, id_customer) VALUES (?, ?, ?, ?)", 
#                  data_to_insert)
conn.commit()

cursor.close()
conn.close()

print("Datos insertados con éxito.")