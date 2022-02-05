import 'dart:async';
import 'dart:io';

import 'package:arriendo/controller/cloudinary/api_cloudinary.dart';
import 'package:arriendo/models/model_galeria/model_galeria.dart';
import 'package:arriendo/pages/galeria/Galeria_fotos_inmueble.dart';
import 'package:arriendo/pages/galeria/foto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ControllerGaleria{
  ModelGaleria model_galeria = new ModelGaleria();
  ApiCloudinary api_cloudinary = new ApiCloudinary();
  void enviar_datos_galeria_fotos_inmueble(int id_inmueble,int id_dueno,BuildContext context)async{
    List datos = await model_galeria.obtenergaleria(id_inmueble.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => GaleriaFotosInmueble(datos:datos,id_dueno: id_dueno,)));
  }

  void enviar_datos_foto_inmueble(int id_dueno,int id_imagen,int id_inmueble,String imagen,BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FotoInmueble(id_imagen: id_imagen.toString(),imagen: imagen,id_inmueble: id_inmueble.toString(),id_dueno: id_dueno,)));
  }

  void ingresar_foto_galeria(int id_inmueble,int id_dueno,File imagen,BuildContext context)async{
    String url_imagen="";
    if(imagen != null){
      url_imagen = await api_cloudinary.uploadFile(imagen);
    }
    int response_statusCode= await model_galeria.insert_galeria(id_inmueble.toString(), url_imagen);
    if(response_statusCode == 200){
      enviar_datos_galeria_fotos_inmueble(id_inmueble,id_dueno, context);
    }
  }

  void eliminar_foto(int gal_id,int id_dueno,int gal_id_inmueble,BuildContext context)async{
    int response_statusCode= await model_galeria.eliminar_foto_galeria(gal_id.toString());
    List datos = await model_galeria.obtenergaleria(gal_id_inmueble.toString());
    if(response_statusCode == 200){
      aviso("Imagen Eliminada", context);       
      Timer(Duration(milliseconds: 2000), ()  {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GaleriaFotosInmueble(datos:datos,id_dueno: id_dueno,)));
      });    
    }
  }
  void aviso(String text , BuildContext context) async {
  showDialog(
        context: context,
        builder: ( BuildContext context) {
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


}