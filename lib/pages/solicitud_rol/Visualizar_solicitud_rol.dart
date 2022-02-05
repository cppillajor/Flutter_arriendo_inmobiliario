import 'package:arriendo/controller/controller_solicitud_rol/controller_solicitud_rol.dart';
import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizarSolicitudRol extends StatefulWidget {
  final List datos;

  const VisualizarSolicitudRol({Key key, this.datos}) : super(key: key);
  @override
  _VisualizarSolicitudRolState createState() =>
      new _VisualizarSolicitudRolState();
}

class _VisualizarSolicitudRolState extends State<VisualizarSolicitudRol> {
  ControllerTipoArriendo controller_tipo_inmueble =
      new ControllerTipoArriendo();
  ControllerSolicitudRol controller_solicitud_rol= new ControllerSolicitudRol();
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
      appBar: AppBar(title:Row(children: <Widget>[Expanded(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Text('Personas Solicitantes rol Arrendatario'),))],) ,),
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
                                  'Usuario',
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
                                  'Descripcion',
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
                                          DataCell(Text(element["per_apellido"])),
                                          DataCell(Text(element["per_usuario"])),
                                          DataCell(Text(element["per_correo"])),
                                          DataCell(
                                              Text(element["sr_descripcion"])),                                          
                                          DataCell(
                                            Row(
                                              children: <Widget>[                                                
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  iconSize: 30.0,
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    aviso_eliminar(
                                                        int.parse(
                                                            element["sr_id"]));
                                                    
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

  void aviso_eliminar(int sr_id) async {
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
                                child:Text('Esta seguro que quiere eliminar' ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue),),

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
                            controller_solicitud_rol.eliminar_solicitud_rol(sr_id, context);
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
