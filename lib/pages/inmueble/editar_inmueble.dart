import 'dart:async';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:arriendo/controller/controller_inmueble/controller_inmueble.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditarInmueble extends StatefulWidget {
  final int id;
  final String imagen;
  final String descripcion;
  final String direccion;
  final String num_cuarto;
  final String num_bano;
  final String num_sala;
  final String num_cocina;
  final String num_parqueadero;
  final String tamano;
  final String contrato;
  final String precio;
  final List tipos_de_inmueble;
  EditarInmueble(
      {Key key,
      this.id,
      this.imagen,
      this.descripcion,
      this.direccion,
      this.num_cuarto,
      this.num_bano,
      this.num_sala,
      this.num_cocina,
      this.num_parqueadero,
      this.tamano,
      this.contrato,
      this.precio,
      this.tipos_de_inmueble})
      : super(key: key);
  @override
  _EditarInmuebleState createState() => new _EditarInmuebleState();
}

class _EditarInmuebleState extends State<EditarInmueble> {
  String nombre_tipo_inmueble;
  int id_tipo_inmueble;
  File _image;
  String inmueble_amoblado;
  List inmueble_amolado_lista = ['SI', 'NO'];
  File pdf_contrato;
  Color colorPdf = Colors.red;
  String imagen_principal_inmueble;
  bool enviar_contrato=false;

  ControllerInmueble controller_inmueble = new ControllerInmueble();
  TextEditingController descripcion = new TextEditingController();
  TextEditingController direccion = new TextEditingController();
  TextEditingController num_cuarto = new TextEditingController();
  TextEditingController num_bano = new TextEditingController();
  TextEditingController num_sala = new TextEditingController();
  TextEditingController num_cocina = new TextEditingController();
  TextEditingController num_parqueadero = new TextEditingController();
  TextEditingController tamano = new TextEditingController();
  TextEditingController precio = new TextEditingController();
  bool obtener_ubicacion=false;
  @override
  void initState() {
    super.initState();
    descripcion.text = widget.descripcion;
    direccion.text = widget.direccion;
    num_cuarto.text = widget.num_cuarto;
    num_bano.text = widget.num_bano;
    num_sala.text = widget.num_sala;
    num_cocina.text = widget.num_cocina;
    num_parqueadero.text = widget.num_parqueadero;
    tamano.text = widget.tamano;
    precio.text = widget.precio;
    if(widget.imagen!=""){
      imagen_principal_inmueble=widget.imagen;
    }else{
      imagen_principal_inmueble=no_foto;
    }
    
  }

  PDFDocument document;

  Future getFile() async {
    File file = await FilePicker.getFile();  
    String extencion_archivo = file.path;
    bool verificar = extencion_archivo.contains('.pdf');
    if (verificar == true) {
      pdf_contrato = file;

      await _cargarPdf();
      _showPdf();
      setState(() {
        colorPdf = Colors.blue;
      });
    } else {
      aviso('Seleccione un archivo PDF');
    }
  }

  void _cargarPdf() async {
    document = await PDFDocument.fromFile(pdf_contrato);
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

    setState(() {
      _image = image;
      Navigator.pop(context);
    });
  }

  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      Navigator.pop(context);
    });
  }
 

  Widget formCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.black,
                ),
                Text('REGRESAR'),
              ],
            ),
            Text("EDITAR INMUEBLE",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: _image==null
                      ? NetworkImage(imagen_principal_inmueble)
                      : FileImage(_image),
                  radius: 50.0,
                ),
                InkWell(
                  onTap: _onAlertPress,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: Colors.black),
                      margin: EdgeInsets.only(top: 70),
                      child: Icon(
                        Icons.photo_camera,
                        size: 25,
                        color: Colors.white,
                      )),
                ),
              ],
            ),

            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Seleccione Tipo de Inmueble:",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(8)),
              child: DropdownButton(
                hint: Text('Seleccione el tipo de Inmueble'),
                dropdownColor: Colors.grey,
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36.0,
                isExpanded: true,
                value: nombre_tipo_inmueble,
                onChanged: (value) {
                  setState(() {
                    nombre_tipo_inmueble = value;
                    id_tipo_inmueble = int.parse(value);
                  });
                },
                items: widget.tipos_de_inmueble.map((value) {
                  return DropdownMenuItem(
                    value: value['tin_id'],
                    child: Text(value['tin_nombre']),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Seleccion Si tiene implementos",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(8)),
              child: DropdownButton(
                hint: Text('Tiene Implementos'),
                dropdownColor: Colors.grey,
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36.0,
                isExpanded: true,
                value: inmueble_amoblado,
                onChanged: (value) {
                  setState(() {
                    inmueble_amoblado = value;
                  });
                },
                items: inmueble_amolado_lista.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Text("Descripcion",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            TextField(
              controller: descripcion,
              decoration: InputDecoration(
                  hintText: "Ingrese Una descripcion del inmueble",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Text("Direccion Inmueble",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            TextField(
              controller: direccion,
              decoration: InputDecoration(
                  hintText: "Ingrese Una descripcion: calle, lugar de residencia",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            amoblado(),
            
            Row(
              children: <Widget>[
                Text('Habilitar Contrato'),
                SizedBox(
                  width: ScreenUtil.getInstance().setWidth(20),
                ),
                Switch(
              value: enviar_contrato,
              onChanged:(value){
                setState(() {
                  enviar_contrato=value;
                });                
              } ,
            ),
                
              ],
            ),
            mostrar_contrato(),     
            Row(
              children: <Widget>[
                Expanded(child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text('¿La ubicacion actual pertenece al inmueble?'),
                )),
                SizedBox(
                  width: ScreenUtil.getInstance().setWidth(20),
                ),
               
                
              ],
            ),
             Switch(
              value: obtener_ubicacion,
              onChanged:(value){
                setState(() {
                  obtener_ubicacion=value;
                });                
              } ,
            ),       
          ],
        ),
      ),
    );
  }
  Widget mostrar_contrato(){
    if(enviar_contrato==true){
      return Row(
              children: <Widget>[
                Text('Seleccione Contrato'),
                SizedBox(
                  width: ScreenUtil.getInstance().setWidth(20),
                ),
                IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  onPressed: () {
                    getFile();
                  },
                  iconSize: 20,
                  color: colorPdf,
                ),
              ],
            );


    }else{
      return Text('');
    }
    
  }
  Widget amoblado() {
    if (inmueble_amoblado == "SI") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Numero de Cuartos",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: num_cuarto,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el numero de cuartos",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Text("Numero de Baños",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: num_bano,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el numero de baños",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Text("Numero de Sala",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: num_sala,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el numero de sala",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Text("Numero de Cocina",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: num_cocina,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el numero de cocinas",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Text("Numero de Parqueadero",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: num_parqueadero,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el numero de parqueaderos",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Text("Tamaño (Area)",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: tamano,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el tamaño del Inmueble",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Text("Precio",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: precio,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el precio",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Text("Tamaño (Area)",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: tamano,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el tamaño del Inmueble",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
          Text("Precio",          
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().setSp(26))),
          TextField(
            controller: precio,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Ingrese el precio",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30),
          ),
        ],
      );
    }
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

  void aviso(String text) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          text,
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomPadding: true,
      body: ElasticInDown(
        duration: Duration(seconds: 2),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset("assets/images/image_01.png"),
                ),
                Expanded(
                  child: Container(),
                ),
                Expanded(child: Image.asset("assets/images/image_02.png"))
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("ARRIENDO INMOBILIARIA",
                                          style: TextStyle(
                                              fontFamily: "Poppins-Bold",
                                              fontSize: ScreenUtil.getInstance()
                                                  .setSp(50),
                                              letterSpacing: .6,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ))),
                        ),
                      ],
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          )),
                    ],
                  ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(50),
                    ),
                    formCard(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(330),
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ]),
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
                                splashColor: Colors.red,
                                onTap: () {
                                  if (descripcion.text != "" &&
                                      tamano.text != "" &&
                                      precio.text != "" &&
                                      id_tipo_inmueble != null &&
                                      inmueble_amoblado != null &&
                                      direccion.text != "") {
                                    controller_inmueble.editar_inmueble(
                                        widget.id,
                                        persona_id,
                                        descripcion.text,
                                        direccion.text,
                                        num_cuarto.text,
                                        num_bano.text,
                                        num_cocina.text,
                                        num_parqueadero.text,
                                        num_sala.text,
                                        precio.text,
                                        tamano.text,
                                        id_tipo_inmueble.toString(),
                                        inmueble_amoblado,
                                        pdf_contrato,
                                        widget.contrato,
                                        enviar_contrato,
                                        _image,
                                        imagen_principal_inmueble,
                                        obtener_ubicacion,
                                        context);
                                  } else {
                                    aviso(
                                        'datos obligatorios: Descripcion, tamaño,precio, tipo de inmueble, Direccion,Implementos');
                                  }                               
                                },
                                child: Center(
                                  child: Text("ACTUALIZAR",
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
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
