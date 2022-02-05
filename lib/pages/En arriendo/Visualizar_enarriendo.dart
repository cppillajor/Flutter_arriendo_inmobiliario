import 'package:animate_do/animate_do.dart';
import 'package:arriendo/controller/controller_enarriendo/controller_en_arriendo.dart';
import 'package:arriendo/controller/controller_pago/controller_pago.dart';
import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizarEnArriendo extends StatefulWidget {
  final List datos;

  const VisualizarEnArriendo({Key key, this.datos}) : super(key: key);

  @override
  _VisualizarEnArriendoState createState() => new _VisualizarEnArriendoState();
}

class _VisualizarEnArriendoState extends State<VisualizarEnArriendo> {
  ControllerTipoArriendo controller_tipo_inmueble =
      new ControllerTipoArriendo();
  ControllerEnArriendo controller_en_arriendo = new ControllerEnArriendo();
  ControllerPago controller_pago = new ControllerPago();
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
      appBar: AppBar(
        title: Text('TABLA DE INMUEBLES ARRENDADOS'),
      ),
      body: BounceInRight(
        child: Container(
          child: Padding(
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
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    onChanged: (value) {
                      setState(() {
                        lista_datos = widget.datos
                            .where((element) => (element['in_descripcion']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                element['per_nombre']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                element['per_apellido']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                element['per_direccion']
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
                              sortColumnIndex: 2,
                              sortAscending: false,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Acciones',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Imagen Inmueble',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Descripcion Inmueble',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Imagen Usuario arrendador',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Nombre ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Apellido',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Direccion',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Telefono',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Correo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                                                    icon: Icon(Icons.list),
                                                    iconSize: 30.0,
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      controller_pago.redireccionar_lista_pago(context, int.parse(element["ea_id_inmueble"]));
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.delete),
                                                    iconSize: 30.0,
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      aviso_eliminar_en_arrendar(
                                                          int.parse(
                                                              element["ea_id"]));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            DataCell(CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  element["in_imagen"]),
                                            )),
                                            DataCell(
                                                Text(element["in_descripcion"])),
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
      ),
    );
  }

  void aviso_eliminar_en_arrendar(int ea_id) async {
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
                            child: Text(
                              'Esta seguro que quiere eliminar',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          disabledColor: Colors.amber,
                          child: Text("ELIMINAR",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          splashColor: Colors.amber,
                          color: Colors.blueAccent,
                          onPressed: () {
                            controller_en_arriendo.eliminar_en_arreindo(
                                ea_id, context);
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
