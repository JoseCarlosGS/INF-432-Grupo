import pyodbc
import random

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=HP\SQLEXPRESS;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

tipo_pago = ['card', 'qr', 'paypal','cash_payment']
cursor.execute("TRUNCATE TABLE payment_method")
for i in range(80000):
    metodo = random.choice(tipo_pago) 
    
    if metodo == 'card':
        number1 = str(random.randint(1000,9999))
        number2 = str(random.randint(1000,9999))    
        number3 = str(random.randint(1000,9999))
        number4 = str(random.randint(1000,9999))
        number = number1+number2+number3+number4
        cursor.execute("INSERT INTO payment_method (number_card, type_method) VALUES (?, ?)", (number, metodo))
    else:
        cursor.execute("INSERT INTO payment_method (number_card, type_method) VALUES (?, ?)", (None,metodo))

conn.commit()

cursor.close()
conn.close()

print("Datos insertados con éxito.")