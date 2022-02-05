import 'package:arriendo/controller/controller_persona/controller_persona.dart';
import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizarTodaPersona extends StatefulWidget {
  final List datos;

  const VisualizarTodaPersona({Key key, this.datos}) : super(key: key);
  @override
  _VisualizarTodaPersonaState createState() =>
      new _VisualizarTodaPersonaState();
}

class _VisualizarTodaPersonaState extends State<VisualizarTodaPersona> {
  ControllerTipoArriendo controller_tipo_inmueble =
      new ControllerTipoArriendo();
  ControllerPersona controller_persona = new ControllerPersona();
  TextEditingController buscar = new TextEditingController();
  List lista_datos;
  @override
  void initState() {    
    lista_datos = widget.datos;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:Text('TABLA PERSONA') ,),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            child: ListView(
              children: <Widget>[                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('BUSCAR',style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),                
                TextField(
                  controller: buscar,
                  decoration: InputDecoration(                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),                    
                    fillColor: Colors.grey,
                    suffixIcon: Icon(Icons.search),
                      hintText: "BUSCAR",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  onChanged: (value) {
                    setState(() {
                      lista_datos = widget.datos
                          .where((element) => (element['per_nombre']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['per_apellido']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['per_direccion']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['per_usuario']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['per_correo']
                                  .toLowerCase()
                                  .contains(value.toLowerCase())))
                          .toList();
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(                            
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Imagen',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nombre',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),                                
                              ),
                              DataColumn(
                                label: Text(
                                  'Apellido',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Direccion',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Telefono',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Correo',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Usuario',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Rol',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Estado',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Acciones',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                            ],
                            rows: lista_datos
                                .map(
                                  ((element) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                element["per_imagen"]),
                                          )),
                                          DataCell(Text(element["per_nombre"])),
                                          DataCell(
                                              Text(element["per_apellido"])),
                                          DataCell(
                                              Text(element["per_direccion"])),
                                          DataCell(
                                              Text(element["per_telefono"])),
                                          DataCell(Text(element["per_correo"])),
                                          DataCell(
                                              Text(element["per_usuario"])),
                                          DataCell(Text(element["rol_nombre"])),
                                          DataCell(element["per_estado"] == '1'
                                              ? Text('Activo')
                                              : Text('INACTIVO')),
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    controller_persona
                                                        .redirreccionar_asignar_rol_persona(
                                                            int.parse(element[
                                                                "per_id"]),
                                                            element["per_nombre"] +
                                                                " " +
                                                                element[
                                                                    "per_apellido"],
                                                            context);
                                                    
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  iconSize: 30.0,
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    aviso_eliminar(
                                                        element["per_nombre"] +
                                                            " " +
                                                            element[
                                                                "per_apellido"],
                                                        int.parse(
                                                            element["per_id"]));
                                                    
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void aviso_eliminar(String per_nombre, int per_id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:Text('Esta seguro que quiere eliminar :' + per_nombre,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue),),

                              )),
                            ),
                          ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          disabledColor: Colors.amber,
                          child: Text("ELIMINAR",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white)),
                          splashColor: Colors.amber,
                          color: Colors.blueAccent,
                          onPressed: () {
                            controller_persona.eliminar_persona(
                                per_id, context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

}
