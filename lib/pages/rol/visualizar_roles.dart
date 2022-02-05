import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizarRol extends StatefulWidget {
  final List datos;
  const VisualizarRol({
    Key key,
    this.datos,
  }) : super(key: key);
  @override
  _VisualizarRolState createState() => new _VisualizarRolState();
}

class _VisualizarRolState extends State<VisualizarRol> {
  TextEditingController buscar = new TextEditingController();
  ControllerTipoArriendo controller_tipo_inmueble =
      new ControllerTipoArriendo();
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
        title: Text('Roles del Sistema'),
      ),
      body: Container(
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
                                .where((element) => (element['rol_nombre']
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element['rol_descripcion']
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
                                        'Nombre',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Descripcion',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Estado',
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
                                                DataCell(Text(
                                                    element["rol_nombre"])),
                                                DataCell(Text(element[
                                                    "rol_descripcion"])),
                                                DataCell(
                                                    element["rol_estado"] == '1'
                                                        ? Text('Activo')
                                                        : Text('INACTIVO')),
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
            : Text("no hay datos"),
      ),
    );
  }
}
