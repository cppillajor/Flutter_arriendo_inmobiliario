import 'package:animate_do/animate_do.dart';
import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerfilUsuario extends StatefulWidget {
  final List datos;
  final String titulo;
  const PerfilUsuario({Key key, this.datos, this.titulo}) : super(key: key);
  @override
  _PerfilUsuarioState createState() => new _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  ControllerTipoArriendo controller_tipo_inmueble =
      new ControllerTipoArriendo();
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
        title: Text(widget.titulo),
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
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
                                                  DataCell(CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        element["per_imagen"]),
                                                  )),
                                                  DataCell(Text(
                                                      element["per_nombre"])),
                                                  DataCell(Text(
                                                      element["per_apellido"])),
                                                  DataCell(Text(
                                                      element["per_direccion"])),
                                                  DataCell(Text(
                                                      element["per_telefono"])),
                                                  DataCell(Text(
                                                      element["per_correo"])),
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
      ),
    );
  }
}
