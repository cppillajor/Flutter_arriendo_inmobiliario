import 'package:arriendo/controller/controller_inmueble/controller_inmueble.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class DestinationScreen extends StatefulWidget {
  final String imagen_tipo_arriendo;
  final List datos;
  DestinationScreen({this.imagen_tipo_arriendo, this.datos});

  @override
  _DestinationScreen createState() => _DestinationScreen();
}

class _DestinationScreen extends State<DestinationScreen> {
  ControllerInmueble controller_inmueble = new ControllerInmueble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElasticInDown(
        duration: Duration(seconds: 2),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: widget.imagen_tipo_arriendo == ""
                          ? NetworkImage(persona_imagen)
                          : NetworkImage(widget.imagen_tipo_arriendo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),                    
                    ],
                  ),
                ),    
              ],
            ),
            Expanded(
              child: widget.datos != null
                  ? ListView.builder(
                      itemCount: widget.datos.length,
                      padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            controller_inmueble.enviar_datos_detalle_inmueble(
                                int.parse(widget.datos[index]['in_id']),
                                int.parse(widget.datos[index]['in_id_persona']),
                                context);                          
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                                height: 170.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      100.0, 20.0, 20.0, 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 120.0,
                                            child: Text(
                                              "Descripcion \n" +
                                                  widget.datos[index]
                                                      ['in_descripcion'],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          Expanded(
                                              child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              "\$"+widget.datos[index]
                                                      ['in_precio_inmueble'] +
                                                  "\n" +
                                                  "PRECIO",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          )), 
                                        ],
                                      ),
                                      Text(
                                        "AMOBLADO: " +
                                            widget.datos[index]
                                                ['in_inmueble_amoblado'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                          child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          padding: EdgeInsets.all(5.0),
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).accentColor,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Tamaño: " +
                                                widget.datos[index]['in_tamaño'],
                                          ),
                                        ),
                                      )),                                    
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20.0,
                                top: 15.0,
                                bottom: 15.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child:Image.network(
                                    widget.datos[index]['in_imagen'],
                                    width: 110.0,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      return loadingProgress==null ? child : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue) ,));
                                    },
                                    /*
                                    image: NetworkImage(
                                      widget.datos[index]['in_imagen'],                                    
                                    ),
                                    */
      
                                    
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Text('No hay datos'),
            ),
          ],
        ),
      ),
    );
  }
}
