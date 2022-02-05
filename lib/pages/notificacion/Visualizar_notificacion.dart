import 'package:animate_do/animate_do.dart';
import 'package:arriendo/controller/controller_notificacion/controller_notificacion.dart';
import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizarNotificacion extends StatefulWidget {
  final List datos;

  const VisualizarNotificacion({Key key, this.datos}) : super(key: key);
  @override
  _VisualizarNotificacionState createState() =>
      new _VisualizarNotificacionState();
}

class _VisualizarNotificacionState extends State<VisualizarNotificacion> {
  ControllerTipoArriendo controller_tipo_inmueble =
      new ControllerTipoArriendo();
  ControllerNotificacion controller_notificacion = new ControllerNotificacion();
  TextEditingController buscar = new TextEditingController();
  List lista_datos;
  @override
  void initState() {
    lista_datos = widget.datos;
    super.initState();
  }

  void _goLoing(String text) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text(text),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TABLA NOTIFICACIONES'),
      ),
      body: BounceInRight(
        child: Container(
          child: widget.datos != null
              ? Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'BUSCAR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextField(
                          controller: buscar,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              fillColor: Colors.grey,
                              suffixIcon: Icon(Icons.search),
                              hintText: "BUSCAR",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12.0)),
                          onChanged: (value) {
                            setState(() {
                              lista_datos = widget.datos
                                  .where((element) => (element['no_descripcion']
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
                                          'Acciones',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'NOTIFICACION',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Imagen Inmueble',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Descripcion Inmueble',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      
                                    ],
                                    rows: lista_datos
                                        .map(
                                          ((element) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell(
                                                    Row(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.info_outline),
                                                          iconSize: 30.0,
                                                          color: Colors.blue,
                                                          onPressed: () {
                                                            controller_notificacion
                                                                .vizualizar_datos_del_arrendatario(
                                                                    int.parse(element[
                                                                        "no_id_persona_arrendatario"]),
                                                                    context);
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon:
                                                              Icon(Icons.delete),
                                                          iconSize: 30.0,
                                                          color: Colors.red,
                                                          onPressed: () {
                                                            controller_notificacion
                                                                .eliminar_notificacion(
                                                                    int.parse(element[
                                                                        "no_id"]),
                                                                    context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DataCell(Text(
                                                      element["no_descripcion"])),
                                                  DataCell(CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        element["in_imagen"]),
                                                  )),
                                                  DataCell(Text(
                                                      element["in_descripcion"])),
                                                  
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
                )
              : Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('TABLA NOTIFICACIONES'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'NOTIFICACION',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Acciones',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ], rows: []),
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
      ),
    );
  }
}
