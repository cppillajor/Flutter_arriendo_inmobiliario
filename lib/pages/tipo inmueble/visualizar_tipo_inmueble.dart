import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizarTipoInmueble extends StatefulWidget {
  final List tipos_de_arriendo;
  VisualizarTipoInmueble({Key key, this.tipos_de_arriendo}) : super(key: key);

  @override
  _VisualizarTipoInmuebleState createState() => _VisualizarTipoInmuebleState();
}

class _VisualizarTipoInmuebleState extends State<VisualizarTipoInmueble> {
  ControllerTipoArriendo controller_tipo_inmueble =
      new ControllerTipoArriendo();
  TextEditingController buscar = new TextEditingController();
  List lista_datos;
  @override
  void initState() {
    lista_datos = widget.tipos_de_arriendo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TIPOS DE INMUEBLES'),
      ),
      body: Padding(
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
                    lista_datos = widget.tipos_de_arriendo
                        .where((element) => (element['tin_nombre']
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element['tin_descripcion']
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
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Nombre',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Detalle',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Acciones',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ],
                          rows: lista_datos
                              .map(
                                ((element) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              element["tin_imagen"]),
                                        )),
                                        DataCell(Text(element["tin_nombre"])),
                                        DataCell(
                                            Text(element["tin_descripcion"])),
                                        DataCell(
                                          Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                iconSize: 30.0,
                                                color: Colors.black,
                                                onPressed: () {
                                                  controller_tipo_inmueble
                                                      .redireccionar_editar_tipo_inmueble(
                                                          int.parse(element[
                                                              "tin_id"]),
                                                          element["tin_nombre"],
                                                          element["tin_imagen"],
                                                          element[
                                                              "tin_descripcion"],
                                                          context);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                iconSize: 30.0,
                                                color: Colors.red,
                                                onPressed: () {
                                                  aviso_eliminar(
                                                      element["tin_nombre"],
                                                      int.parse(
                                                          element["tin_id"]));
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
    );
  }

  void aviso_eliminar(String tin_nombre, int tin_id) async {
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
                              'Esta seguro que quiere eliminar :' + tin_nombre,
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
                          color: Colors.red,
                          onPressed: () {
                            controller_tipo_inmueble.eliminar_tipo_inmueble(
                                tin_id, context);
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
