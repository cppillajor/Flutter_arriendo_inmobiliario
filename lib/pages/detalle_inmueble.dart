import 'package:arriendo/controller/controller_galeria/controller_galeria.dart';
import 'package:arriendo/controller/controller_inmueble/controller_inmueble.dart';
import 'package:arriendo/controller/controller_solicitud_inmueble/controller_solicitud_inmueble.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:share/share.dart';

class DetalleInmueble extends StatefulWidget {
  final List datos;
  final bool editar;
  DetalleInmueble({Key key, this.datos, this.editar}) : super(key: key);
  @override
  _DetalleInmuebleState createState() => _DetalleInmuebleState();
}

class _DetalleInmuebleState extends State<DetalleInmueble> {
  ControllerGaleria controller_galeria = new ControllerGaleria();
  ControllerInmueble controller_inmueble = new ControllerInmueble();
  ControllerSolicitudInmueble controller_solicitud_inmueble =
      new ControllerSolicitudInmueble();
  TextEditingController id_inmueble = new TextEditingController();
  TextEditingController descripcion = new TextEditingController();
  TextEditingController direccion = new TextEditingController();
  TextEditingController num_cuarto = new TextEditingController();
  TextEditingController num_bano = new TextEditingController();
  TextEditingController num_sala = new TextEditingController();
  TextEditingController num_cocina = new TextEditingController();
  TextEditingController num_parqueadero = new TextEditingController();
  TextEditingController tamano = new TextEditingController();
  TextEditingController precio = new TextEditingController();
  TextEditingController contrato = new TextEditingController();
  TextEditingController id_propietario_inmueble = new TextEditingController();
  String arrendatario_contacto;
  String imagen_principal_inmueble = "";
  PDFDocument document;
  String inmueble_amoblado;
  String latitud;
  String longitud;
  
  void aviso(String text) async {
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

  void compartir() {
    String text =
        "DETALLES DEL INMUEBLE \n IMAGEN DEL INMUEBLE: \n $imagen_principal_inmueble \n TAMAÑO DEL INMUEBLE: \n "+tamano.text+" \n DESCRIPCION DEL INMUEBLE: \n "+descripcion.text+" \n DIRECCION DEL INMUEBLE: \n "+direccion.text +"\n PRECIO: \n"+precio.text;
    final RenderBox box = context.findRenderObject();
    Share.share(
      text,
      subject: "Arriendo Inmobiliaria",
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  void _cargarPdf(String pdf) async {
    //print(pdf);
    document = await PDFDocument.fromURL(pdf);
    _showPdf();
  }

  Future<void> _showPdf() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("CONTRATO"),
              content: Center(
                child: PDFViewer(document: document),
              ));
        });
  }

  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      controller_galeria.ingresar_foto_galeria(
          int.parse(id_inmueble.text),int.parse(id_propietario_inmueble.text), image, context);
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      controller_galeria.ingresar_foto_galeria(
          int.parse(id_inmueble.text),int.parse(id_propietario_inmueble.text) ,image, context);
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/camera.png',
                      width: 50,
                    ),
                    Text('Take Photo'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

  void aviso_eliminar(int id_inmueble) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Esta seguro que quiere eliminar este inmueble'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          disabledColor: Colors.amber,
                          child: Text("ELIMINAR"),
                          splashColor: Colors.amber,
                          color: Colors.blueAccent,
                          onPressed: () {
                            controller_inmueble.eliminar_inmueble(
                                id_inmueble, context);
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

  Widget mostrar_inmueble_amoblado(){
    return Column(
      children: <Widget>[
                SizedBox(height: 20),
                num_cuarto.text != ""?                
                Divider(
                  thickness: 0.5,
                  color: Colors.black,
                  indent: 32,
                  endIndent: 32,
                ):SizedBox(),
                num_cuarto.text != ""?
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Numero de Cuarto:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            num_cuarto.text,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox(),
                SizedBox(height: 20),
                num_bano.text!=""?
                Divider(
                  thickness: 0.5,
                  color: Colors.black,
                  indent: 32,
                  endIndent: 32,
                ):SizedBox(),
                num_bano.text!=""?
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Numero de Baño:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            num_bano.text,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox(),
                SizedBox(height: 20),
                num_sala.text!=""?
                Divider(
                  thickness: 0.5,
                  color: Colors.black,
                  indent: 32,
                  endIndent: 32,
                ):SizedBox(),
                num_sala.text!=""?
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Numero de Sala:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            num_sala.text,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox(),                
                SizedBox(height: 20),
                num_cocina.text!=""?
                Divider(
                  thickness: 0.5,
                  color: Colors.black,
                  indent: 32,
                  endIndent: 32,
                ):SizedBox(),
                num_cocina.text!=""?
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Numero de Cocina:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            num_cocina.text,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox(),
                SizedBox(height: 20),
                num_parqueadero.text!=""?
                Divider(
                  thickness: 0.5,
                  color: Colors.black,
                  indent: 32,
                  endIndent: 32,
                ):SizedBox(),
                num_parqueadero.text!=""?
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Numero de Parqueadero:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            num_parqueadero.text,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomIn(
        duration: Duration(seconds: 1),
        child: ListView.builder(
            itemCount: widget.datos.length,
            itemBuilder: (BuildContext context, int index) {
              id_inmueble.text = widget.datos[index]['in_id'];
              id_propietario_inmueble.text = widget.datos[index]['in_id_persona'];
              descripcion.text = widget.datos[index]['in_descripcion'];
              direccion.text = widget.datos[index]['in_direccion'];
              tamano.text = widget.datos[index]['in_tamaño'];
              precio.text = widget.datos[index]['in_precio_inmueble'];
              num_cuarto.text = widget.datos[index]['in_num_cuarto'];
              num_cocina.text = widget.datos[index]['in_num_cocina'];
              num_parqueadero.text = widget.datos[index]['in_num_parqueadero'];
              num_bano.text = widget.datos[index]['in_num_baño'];
              num_sala.text = widget.datos[index]['in_num_sala'];
              imagen_principal_inmueble = widget.datos[index]['in_imagen'];
              contrato.text = widget.datos[index]['in_contrato'];
              inmueble_amoblado=widget.datos[index]['in_inmueble_amoblado'];
              arrendatario_contacto=widget.datos[index]['per_telefono'];
              latitud=widget.datos[index]['in_latitud'];
              longitud=widget.datos[index]['in_longitud'];
              return Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
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
                          child: Image.network(
                            imagen_principal_inmueble,
                            width: MediaQuery.of(context).size.width,
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress==null ? child :  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey) ,),);
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 40.0),
                        child: BounceInRight(
                          duration: Duration(seconds: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Expanded(
                                    child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.arrow_back),
                                        iconSize: 30.0,
                                        color: Colors.black,
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(Icons.picture_as_pdf),
                                              onPressed: () {
                                                _cargarPdf(contrato.text);
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.photo_library),
                                              onPressed: () {
                                                controller_galeria
                                                    .enviar_datos_galeria_fotos_inmueble(
                                                        int.parse(id_inmueble.text),
                                                        int.parse(id_propietario_inmueble.text),context);                                           
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.share),
                                              onPressed: () {
                                                compartir();
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.location_on),
                                              onPressed: () {
                                                controller_inmueble.redirecion_al_mapa(latitud, longitud,arrendatario_contacto, context);
                                              }),
                                          widget.editar
                                              ? IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    controller_inmueble
                                                        .enviar_datos_editar_inmueble(
                                                            int.parse(
                                                                id_inmueble.text),
                                                                imagen_principal_inmueble,
                                                            descripcion.text,
                                                            direccion.text,
                                                            num_cuarto.text,
                                                            num_bano.text,
                                                            num_cocina.text,
                                                            num_parqueadero.text,
                                                            num_sala.text,
                                                            precio.text,
                                                            tamano.text,
                                                            contrato.text,
                                                            context);
                                                  },
                                                )
                                              : Text(''),
                                          widget.editar
                                              ? IconButton(
                                                  icon: Icon(Icons.list),
                                                  iconSize: 30.0,
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    controller_solicitud_inmueble
                                                        .enviar_datos_interesados_inmueble(
                                                            int.parse(
                                                                id_inmueble.text),
                                                            context);
                        
                                                  },
                                                )
                                              : Text(''),
                                          widget.editar
                                              ? IconButton(
                                                  icon: Icon(
                                                      Icons.add_photo_alternate),
                                                  iconSize: 30.0,
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    _onAlertPress();
                                                  },
                                                )
                                              : Text(''),
                                          widget.editar
                                              ? IconButton(
                                                  icon: Icon(Icons.delete),
                                                  iconSize: 30.0,
                                                  color: Colors.redAccent[700],
                                                  onPressed: () {
                                                    aviso_eliminar(int.parse(
                                                        id_inmueble.text));
                                                  },
                                                )
                                              : Text(''),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          
                          
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                                                child: Text(
                            'DESCRIPCION:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                                                child: Text(
                                    descripcion.text,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 32,
                    endIndent: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                                                child: Text(
                            'DIRECCION INMUEBLE:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                                                child: Text(
                              direccion.text,
                              style: TextStyle(fontSize: 20),
                            ),
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ),                
                  Divider(
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 32,
                    endIndent: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'TAMAÑO:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Text(
                              tamano.text,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 32,
                    endIndent: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'PRECIO:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Text(
                              precio.text,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.black,
                    indent: 32,
                    endIndent: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'CONTACTO:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Text(
                              arrendatario_contacto,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  inmueble_amoblado == "SI"?
                  mostrar_inmueble_amoblado():SizedBox(),                
                  int.parse(id_propietario_inmueble.text) != persona_id ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller_solicitud_inmueble.solicitar_inmueble(
                                    int.parse(id_inmueble.text),
                                    persona_id,
                                    int.parse(id_propietario_inmueble.text),
                                    context);                             
                              },
                              child: Center(
                                child: Text("Solicitar Inmueble",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ):Text(''),
                  SizedBox(height: 20),
                ],
              );
            }),
      ),
    );
  }
}
