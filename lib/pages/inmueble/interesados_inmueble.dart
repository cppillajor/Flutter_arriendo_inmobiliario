import 'package:animate_do/animate_do.dart';
import 'package:arriendo/controller/controller_enarriendo/controller_en_arriendo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InteresadosInmueble extends StatefulWidget {
  final List datos;

  const InteresadosInmueble({Key key, this.datos}) : super(key: key);

  @override
  _InteresadosInmuebleState createState() => new _InteresadosInmuebleState();
}

class _InteresadosInmuebleState extends State<InteresadosInmueble> {
  ControllerEnArriendo controller_en_arriendo = new ControllerEnArriendo();
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
      appBar: AppBar(title:Row(children: <Widget>[Expanded(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Text('TABLA DE PERSONAS INTERESADAS POR EL INMUEBLE'),))],) ,),
      body: BounceInRight(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: ListView(
                children: <Widget>[
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
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                  ),
                                ),
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
                                
                              ],
                              rows: lista_datos
                                  .map(
                                    ((element) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon:
                                                        Icon(Icons.check_circle),
                                                    iconSize: 30.0,
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      aviso_arrendar(
                                                          element["per_nombre"] +
                                                              " " +
                                                              element[
                                                                  "per_apellido"],
                                                          int.parse(element[
                                                              "sa_id_persona_solicitante"]),
                                                          int.parse(element[
                                                              "sa_id_inmueble"]));                                                   
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
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

  void aviso_arrendar(
      String nombre, int sa_id_persona_solicitante, int sa_id_inmueble) async {
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
                                child:Text('Esta seguro que quiere arrendar a: ' + nombre,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue),),

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
                          child: Text("ARRENDAR",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white)),
                          splashColor: Colors.amber,
                          color: Colors.blue[300],
                          onPressed: () {
                            controller_en_arriendo.en_arriendo(
                                sa_id_persona_solicitante,
                                sa_id_inmueble,
                                context);
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
