import 'package:arriendo/controller/controller_enarriendo/controller_en_arriendo.dart';
import 'package:arriendo/controller/controller_pago/controller_pago.dart';
import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Visualizarlistapagos extends StatefulWidget {
  final List datos;
  final int id_inmueble;
  const Visualizarlistapagos({Key key, this.datos, this.id_inmueble})
      : super(key: key);

  @override
  _VisualizarlistapagosState createState() => new _VisualizarlistapagosState();
}

class _VisualizarlistapagosState extends State<Visualizarlistapagos> {
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
        title: Text('LISTA DE PAGOS'),
      ),
      body: Container(
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
                          .where((element) => (element['ipm_fecha_pago']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['ipm_valor_mensual']
                                  .toLowerCase()
                                  .contains(value.toLowerCase())))
                          .toList();
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  disabledColor: Colors.amber,
                  child: Text("Agregar",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  splashColor: Colors.amber,
                  color: Colors.blue[300],
                  onPressed: () {
                    controller_pago.redireccionar_agregar_pago(context, widget.id_inmueble);
                  },
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            sortAscending: false,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Fecha de Pago',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Valor del Pago',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Acciones',
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
                                              Text(element["ipm_fecha_pago"])),
                                          DataCell(Text(
                                              element["ipm_valor_mensual"])),
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    controller_pago
                                                        .redireccionar_actualizar_pago(
                                                            context,
                                                            widget.id_inmueble,
                                                            int.parse(element[
                                                            "ipm_id"]),
                                                            element[
                                                                "ipm_fecha_pago"].toString(),
                                                            element[
                                                                "ipm_valor_mensual"].toString());
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
}
