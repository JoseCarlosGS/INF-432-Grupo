import random
import string

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

# Generar un código de reservación
codigo_reservacion = generar_codigo_reservacion()
print("Código de reservación:", codigo_reservacion)