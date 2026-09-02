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

@app.route("/api/hojas-vida/<int:id>")
def obtener_hojasvidaid(id):
    return{
        "Mensaje":"Hoja de vida encontrada","id":id
    }

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

if __name__ == '__main__':
    app.run(debug = True)