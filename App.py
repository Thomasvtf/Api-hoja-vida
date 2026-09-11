from flask import Flask, request
from database import conectar_bd
from flask_cors import CORS
app = Flask(__name__)
CORS(app)

@app.route("/")
def inicio():
    return "Api hoja de vida funcionamiento"

@app.route("/probar")
def probar_bd():
    conec = conectar_bd()
    if conec.is_connected():
        conec.close()
        
        return {
            "mensaje":"database conectada"
        }
        
@app.route("/api/registro-hoja-vida", methods = ["POST"])
def registro_hoja_vida():
    conec = conectar_bd()
    cursor = conec.cursor()
    datos = request.json
    
    correo_nuevo = datos ["correo"]
    
    #Consultar si el correo ya existe
    cursor.execute("SELECT correo FROM hojas_vida WHERE correo = %s", [correo_nuevo])
    busqueda = cursor.fetchone()
    
    if busqueda:
        cursor.close()
        conec.close()
        

        return {"Mensaje":"El correo ya existe"}
        
    sql = """INSERT INTO hojas_vida (nombre, edad, ciudad, correo, fotografia, programa, ficha, jornada) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""
    valor = (
        datos ["nombre"],
        datos ["edad"],
        datos ["ciudad"],
        datos ["correo"],
        datos.get("fotografia"),
        datos ["programa"],
        datos ["ficha"],
        datos ["programa"]
    )
    
    cursor.execute(sql,valor)
    conec.commit()
    
    #Manejo del id de la hoja de vida
    id_generado = cursor.lastrowid
    
    cursor.close()
    conec.close()
    
    return {"Mensaje":"Hoja de vida creada","id": id_generado}

@app.route("/api/hojas-vida/<int:id>", methods=["GET"])
def obtener_hojasvidaid(id):
    
    conec = conectar_bd()
    cursor = conec.cursor(dictionary = True)
    
    cursor.execute("SELECT * FROM hojas_vida WHERE id = %s", (id,))
    
    datos = cursor.fetchone()
    
    
    cursor.close()
    conec.close()
    
    #Qué pasa cuando es nulo
    if datos is None:
        return{"No se encontro la hoja de vida"}
    else:
        return datos
        

@app.route("/api/hojas-vida", methods = ["GET"])
def obtener_hojasvida():
    #return{
    #    "mensaje":"Listado de hojas de vida"
    #}
    conec = conectar_bd()
    cursor = conec.cursor()
    
    cursor.execute("SELECT * FROM hojas_vida")
    listado = cursor.fetchall()
            
    cursor.close()
    conec.close()
    
    return {"Mensaje":"Listado de hojas de vida", "":listado }

#Eliminar hoja de vida
@app.route("/api/eliminar-hoja-vida/<int:id>", methods = ["DELETE"])
def eliminar_hoja_vida(id):
    conec = conectar_bd()
    cursor = conec.cursor()
    
    cursor.execute("SELECT id FROM hojas_vida WHERE id = %s", (id,))
    
    datos = cursor.fetchone()
    
    if datos is None:
        cursor.close()
        conec.close()
        return{"Mensaje":"El id no existe"}
    else:
        cursor.execute("DELETE FROM hojas_vida WHERE id = %s", (id,))
     
        conec.commit()
        
        cursor.close()
        conec.close()
        
        return {"Mensaje":"Registro eliminado"}
    
#Actualizar hoja de vida
@app.route("/api/actualizar-hoja-vida/<int:id>", methods = ["PUT"])
def actualizar_hoja_vida(id):
    datos = request.json
    conec = conectar_bd()
    cursor = conec.cursor(buffered = True)
    
    buscar = """SELECT id FROM hojas_vida WHERE id = %s"""
    cursor.execute(buscar,(id,))

    result = cursor.fetchone()
    
    if result is None:
        cursor.close()
        conec.close()
        return {"Mensaje":"No se encontro la hoja de vida"}, 404
    
    #Validar correo
    sql = """SELECT id FROM hojas_vida WHERE correo = %s and id != %s"""
    cursor.execute(sql, (datos["correo"], id))
    resul = cursor.fetchone()
    
    if resul is not None:
        cursor.close()
        conec.close()
        return{"Mensaje":"El correo ya esta en uso."}, 400

    #Actualizar hoja vida
    sql1 = """UPDATE hojas_vida SET nombre = %s, edad = %s, ciudad = %s, correo = %s, fotografia = %s, programa = %s, ficha = %s, jornada = %s WHERE id = %s"""
    valor = (
            datos ["nombre"],
            datos ["edad"],
            datos ["ciudad"],
            datos ["correo"],
            datos.get("fotografia"),
            datos ["programa"],
            datos ["ficha"],
            datos ["jornada"],
            id
        )

    cursor.execute(sql1,valor)
    conec.commit()
    
    cursor.close()
    conec.close()
    
    return {"Mensaje":"Hoja de vida actualizada","id": id}, 200


#----------------------------------------------#
#                    ESTUDIOS                  #
#----------------------------------------------#

#Registro estudios
@app.route("/api/registro-estudios/<int:id>", methods = ["POST"])
def registro_estudios(id):
    conec = conectar_bd()
    cursor = conec.cursor(buffered = True)
    datos = request.json
    
    #Verificar si existe el id de hoja de vida
    cursor.execute("SELECT id FROM hojas_vida WHERE id = %s", (id,))
    existe = cursor.fetchone()
    
    if existe is None:
        cursor.close()
        conec.close()
        return {"Mensaje":"Id no existe"}, 404

    sql = """INSERT INTO estudios (hoja_vida_id, nivel, institucion, titulo, anio_graduacion) VALUES (%s, %s, %s, %s, %s)"""
    valor = (
        id,
        datos ["nivel"],
        datos ["institucion"],
        datos ["titulo"],
        datos ["anio_graduacion"],
    )
    
    cursor.execute(sql,valor)
    conec.commit()
    
    #Manejo del id de la hoja de vida
    id_generado = cursor.lastrowid
    
    cursor.close()
    conec.close()
    
    return {"Mensaje":"Estudo creado","id": id_generado}, 201

#Consultar estudios de una hoja de vida
@app.route("/api/estudios-hoja-vida/<int:id>", methods = ["GET"])
def estudios_hoja_vida(id):
    conec = conectar_bd()
    cursor = conec.cursor(dictionary=True) 
        
    sql = """
        SELECT h.id AS hoja_vida_id, h.nombre, e.id AS estudio_id, 
               e.nivel, e.institucion, e.titulo, e.anio_graduacion 
        FROM hojas_vida h 
        LEFT JOIN estudios e ON h.id = e.hoja_vida_id 
        WHERE h.id = %s
    """
    cursor.execute(sql, (id,))
    datos = cursor.fetchall()
    
    cursor.close()
    conec.close()
    
    if not datos:
        return {"Mensaje": "No se encontro la hoja de vida"}, 404
        
    if datos[0]['estudio_id'] is None:
        return {"Mensaje": "El id no tiene estudios"}, 200 
        
    return {"estudios": datos}, 200


#Consultar un estudio especifico.
@app.route("/api/consultar-estudio/<int:id>", methods = ["GET"])
def consultar_estudio(id):
    conec = conectar_bd()
    cursor = conec.cursor(dictionary=True)
    
    sql = """SELECT * FROM estudios WHERE id = %s"""
    
    cursor.execute(sql, (id,))
    datos = cursor.fetchone()
    
    cursor.close()
    conec.close()
    
    if datos is None:
        return {"Mensaje":"No se encontraron estudios"}, 200
    
    return {"estudios":datos}

# Actualizar estudio
@app.route("/api/actualizar-estudio/<int:id>", methods = ["PUT"])
def actualizar_estudio(id):
    datos = request.json
    conec = conectar_bd()
    cursor = conec.cursor(buffered = True)
    
    buscar = """SELECT id FROM estudios WHERE id = %s"""
    cursor.execute(buscar,(id,))

    result = cursor.fetchone()
    
    if result is None:
        cursor.close()
        conec.close()
        return {"Mensaje":"No se encontro estudios"}, 404

    #Actualizar estudios
    sql = """UPDATE estudios SET nivel = %s, institucion = %s, titulo = %s, anio_graduacion = %s WHERE id = %s"""
    valor = (
            datos ["nivel"],
            datos ["institucion"],
            datos ["titulo"],
            datos ["anio_graduacion"],
            id
        )

    cursor.execute(sql,valor)
    conec.commit()
    
    cursor.close()
    conec.close()
    
    return {"Mensaje":"Estudios actualizada","id": id}, 200
    
#Eliminar estudio
@app.route("/api/eliminar-estudio/<int:id>", methods = ["DELETE"])
def eliminar_estudio(id):
    conec = conectar_bd()
    cursor = conec.cursor()
    
    cursor.execute("SELECT id FROM estudios WHERE id = %s", (id,))
    
    datos = cursor.fetchone()
    
    if datos is None:
        cursor.close()
        conec.close()
        return{"Mensaje":"El id no existe"}, 404
    else:
        cursor.execute("DELETE FROM estudios WHERE id = %s", (id,))
     
        conec.commit()
        
        cursor.close()
        conec.close()
        
        return {"Mensaje":"Estudio eliminado"}
    
    
#------------------------------------------------------#
#                    Experiencias                      #
#------------------------------------------------------#

#Registro experiencias
@app.route("/api/registro-experiencia/<int:id>", methods = ["POST"])
def registro_experiencia(id):
    conec = conectar_bd()
    cursor = conec.cursor(buffered = True)
    datos = request.json
    
    #Verificar si existe el id de hoja de vida
    cursor.execute("SELECT id FROM hojas_vida WHERE id = %s", (id,))
    existe = cursor.fetchone()
    
    if existe is None:
        cursor.close()
        conec.close()
        return {"Mensaje":"Id no existe"}, 404

    sql = """INSERT INTO experiencias (hoja_vida_id, empresa, cargo, tiempo, funciones) VALUES (%s, %s, %s, %s, %s)"""
    valor = (
        id,
        datos ["empresa"],
        datos ["cargo"],
        datos ["tiempo"],
        datos ["funciones"],
    )
    
    cursor.execute(sql,valor)
    conec.commit()
    
    #Manejo del id de la hoja de vida
    id_generado = cursor.lastrowid
    
    cursor.close()
    conec.close()
    
    return {"Mensaje":"Experiencia creada","id": id_generado}, 201

#Consultar experiencias de una hoja de vida
@app.route("/api/experiencias-hoja-vida/<int:id>", methods = ["GET"])
def experiencia_hoja_vida(id):
    conec = conectar_bd()
    cursor = conec.cursor(dictionary=True) 
        
    sql = """
        SELECT h.id AS hoja_vida_id, h.nombre, e.id AS experiencia_id, 
               e.empresa, e.cargo, e.tiempo, e.funciones 
        FROM hojas_vida h 
        LEFT JOIN experiencias e ON h.id = e.hoja_vida_id 
        WHERE h.id = %s
    """
    cursor.execute(sql, (id,))
    datos = cursor.fetchall()
    
    cursor.close()
    conec.close()
    
    if not datos:
        return {"Mensaje": "No se encontro la hoja de vida"}, 404
        
    if datos[0]['experiencia_id'] is None:
        return {"Mensaje": "El id no tiene experiencias"}, 200 
        
    return {"estudios": datos}, 200

#Consultar una experiencia especifica.
@app.route("/api/consultar-experiencia/<int:id>", methods = ["GET"])
def consultar_experiencia(id):
    conec = conectar_bd()
    cursor = conec.cursor(dictionary=True)
    
    sql = """SELECT * FROM experiencias WHERE id = %s"""
    
    cursor.execute(sql, (id,))
    datos = cursor.fetchone()
    
    cursor.close()
    conec.close()
    
    if datos is None:
        return {"Mensaje":"No se encontraron experiencias"}, 200
    
    return {"Experiencias":datos}

# Actualizar experiencia
@app.route("/api/actualizar-experiencia/<int:id>", methods = ["PUT"])
def actualizar_experiencia(id):
    datos = request.json
    conec = conectar_bd()
    cursor = conec.cursor(buffered = True)
    
    buscar = """SELECT id FROM experiencias WHERE id = %s"""
    cursor.execute(buscar,(id,))

    result = cursor.fetchone()
    
    if result is None:
        cursor.close()
        conec.close()
        return {"Mensaje":"No se encontro experiencias"}, 404

    #Actualizar experiencia
    sql = """UPDATE experiencias SET empresa = %s, cargo = %s, tiempo = %s, funciones = %s WHERE id = %s"""
    valor = (
            datos ["empresa"],
            datos ["cargo"],
            datos ["tiempo"],
            datos ["funciones"],
            id
        )

    cursor.execute(sql,valor)
    conec.commit()
    
    cursor.close()
    conec.close()
    
    return {"Mensaje":"Experiencias actualizada","id": id}, 200


#--------------------------------------------#
#                Habilidades                 #
#--------------------------------------------#

#Registro de habilidades
@app.route("/api/registro-habilidad/<int:id>", methods = ["POST"])
def registro_habilidades(id):
    conec = conectar_bd()
    cursor = conec.cursor()

    datos = request.json

    sql = """SELECT id FROM experiencias WHERE id = %s"""
    cursor.execute(sql, (id,))

    result = cursor.fetchone()

    if result is None:
        cursor.close()
        conec.close()
        return {"Mensaje": "No se encontró la experiencia"}, 404

    sql = """INSERT INTO habilidades (experiencias_id, nombre) VALUES (%s, %s)"""

    valor = (
        id,
        datos["nombre"] 
    )

    cursor.execute(sql, valor)
    conec.commit()

    cursor.close()
    conec.close()

    id_generado = cursor.lastrowid

    return {"Mensaje": "Habilidad registrada", "id": id_generado}, 200

#Consultar habilidades de una experiencia
@app.route("/api/habilidades-experiencia/<int:id>", methods = ["GET"])
def habilidades_experiencia(id):
    conec = conectar_bd()
    cursor = conec.cursor(dictionary=True)

    sql = """SELECT h.id AS habilidad_id, h.nombre, e.id AS experiencia_id, e.empresa, e.cargo
             FROM habilidades h
             LEFT JOIN experiencias e ON h.experiencias_id = e.id
             WHERE e.id = %s"""

    cursor.execute(sql, (id,))
    datos = cursor.fetchall()

    cursor.close()
    conec.close()

    if not datos:
        return {"Mensaje": "No se encontraron habilidades para la experiencia"}, 404

    return {"habilidades": datos}, 200

#consultar una habilidad especifica
@app.route("/api/consultar-habilidad/<int:id>", methods = ["GET"])
def consultar_habilidad(id):
    conec = conectar_bd()
    cursor = conec.cursor(dictionary=True)

    sql = """SELECT * FROM habilidades WHERE id = %s"""

    cursor.execute(sql, (id,))
    datos = cursor.fetchone()

    cursor.close()
    conec.close()

    if datos is None:
        return {"Mensaje": "No se encontró la habilidad"}, 404

    return {"habilidad": datos}, 200

#Actualizar habilidad
@app.route("/api/actualizar-habilidad/<int:id>", methods = ["PUT"])
def actualizar_habilidad(id):
    datos = request.json
    conec = conectar_bd()
    cursor = conec.cursor(buffered=True)

    buscar = """SELECT id FROM habilidades WHERE id = %s"""
    cursor.execute(buscar, (id,))

    result = cursor.fetchone()

    if result is None:
        cursor.close()
        conec.close()
        return {"Mensaje": "No se encontró la habilidad"}, 404

    # Actualizar habilidad
    sql = """UPDATE habilidades SET nombre = %s WHERE id = %s"""
    valor = (
        datos["nombre"],
        id
    )

    cursor.execute(sql, valor)
    conec.commit()

    cursor.close()
    conec.close()

    return {"Mensaje": "Habilidad actualizada", "id": id}, 200

#Eliminar habilidad
@app.route("/api/eliminar-habilidad/<int:id>", methods=["DELETE"])
def eliminar_habilidad(id):
    conec = conectar_bd()
    cursor = conec.cursor()

    cursor.execute("SELECT id FROM habilidades WHERE id = %s", (id,))

    datos = cursor.fetchone()

    if datos is None:
        cursor.close()
        conec.close()
        return {"Mensaje": "El id no existe"}, 404
    else:
        cursor.execute("DELETE FROM habilidades WHERE id = %s", (id,))

        conec.commit()

        cursor.close()
        conec.close()

        return {"Mensaje": "Habilidad eliminada"}

if __name__ == '__main__':
    app.run(debug = True)