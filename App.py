from flask import Flask, request
from database import conectar_bd
app = Flask(__name__)

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
        datos ["hoja_vida_id": id],
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
    
    return {"Mensaje":"Estudo creado","id": id_generado}


if __name__ == '__main__':
    app.run(debug = True)