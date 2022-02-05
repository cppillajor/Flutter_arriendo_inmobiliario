import 'dart:async';
import 'dart:io';
import 'package:arriendo/controller/cloudinary/api_cloudinary.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:arriendo/models/model_tipo_inmueble/model_tipo_arriendo.dart';
import 'package:arriendo/pages/home_screen.dart';
import 'package:arriendo/pages/tipo%20inmueble/editar_tipo_inmueble.dart';
import 'package:arriendo/pages/tipo%20inmueble/ingresar_tipo_inmueble.dart';
import 'package:arriendo/pages/tipo%20inmueble/visualizar_tipo_inmueble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ControllerTipoArriendo{
  ModelTipoArriendo model_tipo_arriendo = new ModelTipoArriendo();
  ApiCloudinary api_cloudinary = new ApiCloudinary();
  Future<List> obtenerTiposArriendo() async{    
    var respuesta = await model_tipo_arriendo.obtenerTiposArriendo();    
    return respuesta;  
  }

  void enviar_datos_homescreen(BuildContext context)async{
    List resultado = await model_tipo_arriendo.obtenerTiposArriendo();    
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(datos: resultado,)));   
  }  

  void enviar_datos_visualizar_tipo_inmueble(BuildContext context)async{
    List datos = await model_tipo_arriendo.obtenerTiposArriendo();
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisualizarTipoInmueble(tipos_de_arriendo:datos)));


  }
  void redireccionar_ingresar_tipo_inmueble(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => IngresarTipoInmueble()));
  }

  void ingresar_tipo_inmueble(String nombre,File imagen,String descripcion,BuildContext context)async{
    String url_imagen="";
    if(imagen != null){
      url_imagen = await api_cloudinary.uploadFile(imagen);
    }else{
      url_imagen=no_foto;
    } 
    int response_statusCode = await model_tipo_arriendo.ingresar_tipo_inmueble(nombre, descripcion, url_imagen);
    List resultado = await model_tipo_arriendo.obtenerTiposArriendo(); 
    if(response_statusCode == 200){
      aviso("tipo inmueble ingresado con exito", context);
      Timer(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(datos: resultado,)));
      });
    }
  }
  void eliminar_tipo_inmueble(int id_tipo_inmueble ,BuildContext context)async{
    int response_statusCode = await model_tipo_arriendo.eliminar_tipo_inmueble(id_tipo_inmueble.toString());
    List resultado = await model_tipo_arriendo.obtenerTiposArriendo(); 
    if(response_statusCode == 200){
      aviso("Eliminado", context);
      Timer(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(datos: resultado,)));
      });
    }
  }

  

  void redireccionar_editar_tipo_inmueble(int id_tipo_inmueble,String nombre,String imagen,String descripcion,BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditarTipoInmueble(id: id_tipo_inmueble,descripcion: descripcion,imagen: imagen,nombre: nombre)));    
  }
  void editar_tipo_inmueble(int id_tipo_inmueble,String nombre,File imagen,String descripcion,String imagen_anterior,BuildContext context)async{
    String url_imagen="";
    if(imagen != null){
      url_imagen = await api_cloudinary.uploadFile(imagen);
    }else{
      url_imagen=imagen_anterior;      
    }
    int response_statusCode=await model_tipo_arriendo.editar_tipo_inmueble(id_tipo_inmueble.toString(), nombre, descripcion, url_imagen);
    List resultado = await model_tipo_arriendo.obtenerTiposArriendo();
    if(response_statusCode == 200){
      aviso("Editado con exito", context);
      Timer(Duration(milliseconds: 2000), () {  
        Navigator.pop(context) ;
        Navigator.pop(context) ;
        Navigator.pop(context) ;
        Navigator.pop(context) ;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(datos: resultado,)));
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