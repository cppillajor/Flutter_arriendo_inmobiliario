import 'package:animate_do/animate_do.dart';
import 'package:arriendo/controller/controller_galeria/controller_galeria.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class FotoInmueble extends StatefulWidget {
  final String imagen;
  final String id_inmueble;
  final String id_imagen;
  final int id_dueno;
  FotoInmueble({Key key, this.id_imagen, this.imagen, this.id_inmueble,this.id_dueno})
      : super(key: key);

  @override
  _FotoInmuebleState createState() => _FotoInmuebleState();
}

class _FotoInmuebleState extends State<FotoInmueble> {
  ControllerGaleria controller_galeria = new ControllerGaleria();   
  void compartir() {
    String text ="Revisa esta imagen de un inmueble, puede ser de tu agrado. \n "+widget.imagen;
    final RenderBox box = context.findRenderObject();
    Share.share(
      text,
      subject: "Arriendo Inmobiliaria",
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
              iconSize: 30,
              color: Colors.white,
              icon: Icon(Icons.share),
              onPressed: () {
                compartir();
                
          }),
          widget.id_dueno == persona_id?
          IconButton(
              iconSize: 30,
              color: Colors.white,
              icon: Icon(Icons.delete),
              onPressed: () {
                aviso_eliminar();
              }):Text(''),
        ],
      ),
      backgroundColor: Colors.black,
      body: ZoomIn(
        child: Center(
          child: Image.network(
            widget.imagen,
            loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress==null ? child :  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey) ,),);
            },
          ),
        ),
      ),
    );
  }

  void aviso_eliminar() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Esta seguro que quiere eliminar la foto'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          disabledColor: Colors.amber,
                          child: Text("ELIMINAR"),
                          splashColor: Colors.amber,
                          color: Colors.blueAccent,
                          onPressed: () {
                            controller_galeria.eliminar_foto(
                                int.parse(widget.id_imagen),
                                widget.id_dueno,
                                int.parse(widget.id_inmueble),
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
