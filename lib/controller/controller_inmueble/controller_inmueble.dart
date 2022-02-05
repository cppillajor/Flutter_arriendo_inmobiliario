import 'dart:async';
import 'dart:io';
import 'package:arriendo/controller/cloudinary/api_cloudinary.dart';
import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:arriendo/controller/ubicacion/ubicacion.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:arriendo/models/model_inmueble/model_inmueble.dart';
import 'package:arriendo/models/model_tipo_inmueble/model_tipo_arriendo.dart';
import 'package:arriendo/pages/destination_screen.dart';
import 'package:arriendo/pages/detalle_inmueble.dart';
import 'package:arriendo/pages/home_screen.dart';
import 'package:arriendo/pages/inmueble/editar_inmueble.dart';
import 'package:arriendo/pages/inmueble/ingresar_inmueble.dart';
import 'package:arriendo/pages/mapa/mapa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ControllerInmueble {
  ModelInmueble model_inmueble = new ModelInmueble();
  ModelTipoArriendo model_tipo_arriendo = new ModelTipoArriendo();
  ApiCloudinary api_cloudinary = new ApiCloudinary();
  ControllerTipoArriendo controller_tipo_arreindo = new ControllerTipoArriendo();
   
  void enviar_datos_destinationscreen(
      int id, String tipo_busqueda, BuildContext context) async {
    List datos;
    String imagen_tipo_arriendo = "";
    if (tipo_busqueda == "inmueble_segun_tipo_inmueble") {
      datos = await model_inmueble.obtenertiposinmueble(id.toString());
      if (!datos.isEmpty) {
        imagen_tipo_arriendo = datos[0]['tin_imagen'];
      } else {
        imagen_tipo_arriendo = "";
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DestinationScreen(
                    datos: datos,
                    imagen_tipo_arriendo: imagen_tipo_arriendo,
                  )));
    } else {
      if (tipo_busqueda == "segun_id_persona") {
        datos = await model_inmueble.obtener_inmuebles_segun_id_persona();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DestinationScreen(
                      datos: datos,
                      imagen_tipo_arriendo: imagen_tipo_arriendo,
                    )));
      }
    }
  }

  void enviar_datos_detalle_inmueble(
      int id_inmueble, int id_dueno_inmueble, BuildContext context) async {
    bool editar = false;
    if (id_dueno_inmueble == persona_id) {
      editar = true;
    }
    List datos = await model_inmueble
        .obtener_inmueble_segun_id_inmueble(id_inmueble.toString());
    if (datos != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetalleInmueble(
                    datos: datos,
                    editar: editar,
                  )));
    }
  }

  void enviar_datos_editar_inmueble(
    
      int id_inmueble,
      String imagen,
      String descripcion,
      String direccion,
      String num_cuarto,
      String num_bano,
      String num_cocina,
      String num_parqueadero,
      String num_sala,
      String precio,
      String tamano,
      String contrato,
      BuildContext context) async{
        List tipos_de_inmueble = await model_tipo_arriendo.obtenerTiposArriendo();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarInmueble(
          id: id_inmueble,
          imagen: imagen,
          descripcion: descripcion,
          direccion: direccion,
          num_cuarto: num_cuarto,
          num_bano: num_bano,
          num_cocina: num_cocina,
          num_parqueadero: num_parqueadero,
          num_sala: num_sala,
          precio: precio,
          tamano: tamano,
          contrato: contrato,
          tipos_de_inmueble: tipos_de_inmueble,
        ),
      ),
    );
  }

  void editar_inmueble(
      int id_inmueble,
      int id_dueno_inmueble,
      String descripcion,
      String direccion,
      String num_cuarto,
      String num_bano,
      String num_cocina,
      String num_parqueadero,
      String num_sala,
      String precio,
      String tamano,
      String id_tipo_inmueble,
      String inmueble_amoblado,
      File contrato_nuevo,
      String contrato_anterior,
      bool enviar_contrato,
      File imagen,
      String imagen_anterior,
      bool obtener_ubicacion,
      BuildContext context
  ) async{
    String url_contrato = "";
    String url_imagen = "";
    Ubicacion obj_ubicacion = new Ubicacion();
    Position position;
    String latitud="";
    String longitud="";
    if(imagen != null){
      url_imagen = await api_cloudinary.uploadFile(imagen);
    }else{
      url_imagen=imagen_anterior;
    }
    if(enviar_contrato == true){
      if(contrato_nuevo != null){
      url_contrato = await api_cloudinary.uploadFile(contrato_nuevo);
    }else{
      url_contrato=contrato_anterior;
    }

    }else{
      url_contrato=no_contrato;
    }
    
    if(inmueble_amoblado==""){
      inmueble_amoblado="NO";
    }
    if(obtener_ubicacion==true){
      position = await obj_ubicacion.determinePosition();
      if(position!=null){
        latitud=position.latitude.toString();
        longitud=position.longitude.toString();
      }else{
        aviso('Ubicacion denegada', context);
        latitud="";
        longitud="";
      }
      
    }
    int statusCode = await model_inmueble.actualizar_inmueble(id_inmueble.toString(), descripcion, direccion,num_cuarto, num_bano, num_cocina, num_parqueadero, num_sala, precio, tamano, id_tipo_inmueble, inmueble_amoblado, url_contrato, url_imagen,latitud,longitud);

    List datos = await model_inmueble.obtener_inmuebles_segun_id_persona();
    if (statusCode == 200) {      
      Navigator.pop(context);
      Navigator.pop(context);
      
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DestinationScreen(datos: datos,imagen_tipo_arriendo: '',)));
      
    } else {
      controller_tipo_arreindo.enviar_datos_homescreen(context);
    }
    
    
  }
  void redireccionar_ingresar_inmueble(BuildContext context)async{
    List tipos_arriendo = await model_tipo_arriendo.obtenerTiposArriendo();
    Navigator.push(context, MaterialPageRoute(builder: (context) => IngresarInmueble(tipos_de_arriendo: tipos_arriendo,)));

  }
  void ingresar_inmueble( 
      String descripcion,
      String direccion,
      String num_cuarto,
      String num_bano,
      String num_cocina,
      String num_parqueadero,
      String num_sala,
      String precio,
      String tamano,
      String id_tipo_inmueble,
      String inmueble_amoblado,
      File contrato,
      bool enviar_contrato,
      File imagen,      
      bool obtener_ubicacion,
      BuildContext context
  )async{
    String url_contrato = "";
    String url_imagen = "";
    Ubicacion obj_ubicacion = new Ubicacion();
    Position position;
    String latitud="";
    String longitud="";
    if(imagen != null){
      url_imagen = await api_cloudinary.uploadFile(imagen);
    }else{
      url_imagen=no_foto;
    }
    if(enviar_contrato==true){
      if(contrato != null){
      url_contrato = await api_cloudinary.uploadFile(contrato);
    }else{
      url_contrato=no_contrato;
    }

    }else{
      url_contrato=no_contrato;
    }
    
    if(inmueble_amoblado==""){
      inmueble_amoblado="NO";
    }

    if(obtener_ubicacion==true){
      position = await obj_ubicacion.determinePosition();
      if(position!=null){
        latitud=position.latitude.toString();
        longitud=position.longitude.toString();
      }else{
        aviso('Ubicacion denegada', context);
        latitud="";
        longitud="";
      }
      
    }

  
    int response_statusCode= await model_inmueble.ingresar_inmueble(descripcion,direccion, num_cuarto, num_bano, num_cocina, num_parqueadero, num_sala, precio, tamano, id_tipo_inmueble, inmueble_amoblado, url_contrato, url_imagen,latitud,longitud);
    if(response_statusCode == 200){
      Navigator.pop(context);
      enviar_datos_destinationscreen(0, "segun_id_persona", context);
    }

  }

  void eliminar_inmueble(int id_inmueble, BuildContext context) async{
    int response_statusCode = await model_inmueble.eliminar_inmueble(id_inmueble.toString());
    List datos = await model_inmueble.obtener_inmuebles_segun_id_persona();
    if(response_statusCode == 200){
      aviso("Eliminado", context);
      Timer(Duration(milliseconds: 2000), (){   
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DestinationScreen(datos: datos,imagen_tipo_arriendo: '',)));
      });
    }
    
  }
  void redirecion_al_mapa(String latitud,String longitud,String arrendatario_contacto, BuildContext context){
    if(latitud !="" && longitud!=""){
    Navigator.push(context,MaterialPageRoute(builder: (context) => VistaMapa(latitud: double.parse(latitud),longitud: double.parse(longitud),telefono: arrendatario_contacto,)));
    }else{
      aviso('NO COORDENADAS', context);
    }
  }
  void aviso(String text, BuildContext context) async {
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



  

}
