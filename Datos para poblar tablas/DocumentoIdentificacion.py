import random
import pyodbc
import string

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=HP\SQLEXPRESS;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

 

#cursor.execute("TRUNCATE TABLE identification_document")
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

def generate_number(tipo):
    if tipo == 1:
        return str(random.randint(1561231, 9996899))
    
    if tipo == 2:
        return ''.join(random.choices(string.ascii_uppercase, k=2)) + ''.join(random.choices(string.digits, k=5))
    
    if tipo == 3:
        return str(random.randint(15612310, 99968990))

    if tipo == 4:
        return ''.join(random.choices(string.digits, k=7)) + ''.join(random.choices(string.ascii_uppercase, k=2))

codigo1 = set()
codigo2 = set()
codigo3 = set()
codigo4 = set()
data_to_insert = []

for i in range(80000):
    fecha_ini = fecha_random(2020,2023)
    fecha_exp = fecha_random(2025,2030)
    id_pais = random.randint(1,200)
    id_tipo = random.randint(1,4)
    while True:
        if id_tipo == 1:
            codigo = generate_number(1)
            if codigo not in codigo1:
                codigo1.add(codigo)
                break
        if id_tipo == 2:
            codigo = generate_number(2)
            if codigo not in codigo1:
                codigo2.add(codigo)
                break
        if id_tipo == 3:
            codigo = generate_number(3)
            if codigo not in codigo1:
                codigo3.add(codigo)
                break
        if id_tipo == 4:
            codigo = generate_number(4)
            if codigo not in codigo1:
                codigo4.add(codigo)
                break
    data_to_insert.append((codigo, id_tipo, fecha_ini, fecha_exp, id_pais))
    
batch_size = 1000  
for i in range(0, len(data_to_insert), batch_size):
    batch = data_to_insert[i:i + batch_size]
    cursor.executemany("INSERT INTO identification_document (document_number, document_type_id, issue_date, expiration_date, issue_country) VALUES (?, ?, ?, ?, ?)", batch)
    
conn.commit()

cursor.close()
conn.close()

print("Datos insertados con éxito.")