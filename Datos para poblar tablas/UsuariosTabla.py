import pyodbc
import random

# Conexión a SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=HP\SQLEXPRESS;DATABASE=AirlineReservation;Trusted_Connection=yes')
cursor = conn.cursor()

# Listas de nombres y apellidos para generar datos aleatorios
nombres = [
    'Juan', 'María', 'Carlos', 'Ana', 'Pedro', 'Laura', 'Luis', 'Carmen', 'José', 'Paula',
    'Ricardo', 'Marta', 'Sofía', 'Andrés', 'Jorge', 'Elena', 'Felipe', 'Isabel', 'Manuel', 'Victoria',
    'Francisco', 'Gabriela', 'Pablo', 'Daniela', 'Raúl', 'Lucía', 'Miguel', 'Clara', 'Fernando', 'Rosa'
]
apellidos = [
    'García', 'Martínez', 'López', 'Hernández', 'González', 'Pérez', 'Sánchez', 'Ramírez', 'Torres', 'Rodríguez',
    'Vega', 'Morales', 'Rojas', 'Castillo', 'Ortiz', 'Cruz', 'Delgado', 'Mendoza', 'Reyes', 'Guerrero',
    'Navarro', 'Romero', 'Flores', 'Mejía', 'Campos', 'Rivas', 'Castro', 'Vargas', 'Acosta', 'Moreno'
]
# Insertar 160,000 registros
for i in range(160000):
    nombre = random.choice(nombres)
    apellido = random.choice(apellidos)
    cursor.execute("INSERT INTO person ([name], last_name) VALUES (?, ?)", (nombre, apellido))

# Confirmar la inserción
conn.commit()

# Cerrar cursor y conexión
cursor.close()
conn.close()

print("Datos insertados con éxito.")
