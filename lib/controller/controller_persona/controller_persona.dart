import 'dart:async';
import 'dart:io';
import 'package:arriendo/controller/cloudinary/api_cloudinary.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:arriendo/models/model_persona/model_persona.dart';
import 'package:arriendo/models/model_rol/model_rol.dart';
import 'package:arriendo/models/model_tipo_inmueble/model_tipo_arriendo.dart';
import 'package:arriendo/pages/home_screen.dart';
import 'package:arriendo/pages/login-registro/login.dart';
import 'package:arriendo/pages/login-registro/registro.dart';
import 'package:arriendo/pages/persona/Visualizar_toda_persona.dart';
import 'package:arriendo/pages/persona/asignar_rol_persona.dart';
import 'package:arriendo/pages/persona/editar_perfil.dart';
import 'package:arriendo/pages/persona/perfil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
final key = encrypt.Key.fromLength(32);
final iv = encrypt.IV.fromLength(16);
final encrypter = encrypt.Encrypter(encrypt.AES(key));
class ControllerPersona {
  ModelPersona model_persona = new ModelPersona();
  ModelTipoArriendo model_tipo_arriendo = new ModelTipoArriendo();
  ApiCloudinary api_cloudinary = new ApiCloudinary();
  ModelRol model_rol = new ModelRol();
  
  String encriptar(String valor){     
    final encrypted = encrypter.encrypt(valor, iv: iv);
    return encrypted.base64.toString();
  }

  void controller_login(
      String usuario, String password,bool encriptar_clave, BuildContext context) async {
      String clave="";
      if(encriptar_clave==true){
        clave = encriptar(password);
      }else{
        clave=password;
      }
      
    var resultado = await model_persona.model_logIn(usuario, clave);
    List resultado2 = await model_tipo_arriendo.obtenerTiposArriendo();
    if (resultado != null) {
      for (var item in resultado) {
        persona_id = int.parse(item['per_id']);
        persona_nombre = item['per_nombre'];
        persona_apellido = item['per_apellido'];
        persona_direccion = item['per_direccion'];
        persona_telefono = item['per_telefono'];
        persona_correo = item['per_correo'];
        persona_imagen = item['per_imagen'];
        persona_usuario = item['per_usuario'];
        persona_rol = int.parse(item['per_rol']);
      }
      if (persona_nombre != "") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      datos: resultado2,
                    )));
      } else {
        aviso("No es usuario perteneciente al sistema", context);
      }
    } else {
      aviso("No es usuario perteneciente al sistema", context);
    }
  }

  void redirreccionar_registro(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Registro()));
  }

  String comprobar_correo(String correo) {
    var comprobar = correo.split("@");
    if (comprobar.length > 1) {
      String correoparte_2 = comprobar[1].replaceAll(" ", "");
      String correoparte_1 = comprobar[0].replaceAll(" ", "");
      if (correoparte_1 != "" && correoparte_2 != "") {
        return correoparte_1 + "@" + correoparte_2;
      }
    }
    return "";
  }

  void registro_usuario(
      String nombre,
      String apellido,
      String direccion,
      String telefono,
      File imagen,
      String correo,
      String password,
      BuildContext context) async {
    var usuario = correo.split("@");
    List comprobar_usuario_existente = await model_persona
        .comprobar_correo_usuario_existente(correo, usuario[0].toString());
    if (comprobar_usuario_existente.isEmpty) {
      String url_imagen = "";
      if (imagen != null) {
        url_imagen = await api_cloudinary.uploadFile(imagen);
      } else {
        url_imagen = no_foto;
      }
      String clave = encriptar(password);
      int response_statusCode = await model_persona.registro_usuario(
          nombre,
          apellido,
          direccion,
          telefono,
          url_imagen,
          correo,
          usuario[0].toString(),
          clave);

      if (response_statusCode == 200) {
        controller_login(usuario[0].toString(), clave,false, context);
      }
    } else {
      aviso('CORREO YA EXISTENTE', context);
    }
  }

  void visualizar_todas_las_personas(BuildContext context) async {
    List datos = await model_persona.select_todas_personas();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VisualizarTodaPersona(
                  datos: datos,
                )));
  }

  void eliminar_persona(int id_persona, BuildContext context) async {
    
    int response_statusCode = await model_persona.eliminar_persona(id_persona.toString());
    List datos = await model_persona.select_todas_personas();
    if (response_statusCode == 200) {
      aviso("Eliminado", context);
      Timer(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VisualizarTodaPersona(datos: datos,)));
      });
    }
  }

  void redireccionar_editar_perfil(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditarPerfil()));
  }

  void editar_perfil(
      int persona_id,
      String nombre,
      String apellido,
      String direccion,
      String telefono,
      File imagen,
      String correo,
      String usuario,
      String password,
      BuildContext context) async {
    usuario = usuario.replaceAll(" ", "");    

    List comprobar_usuario_existente =
        await model_persona.comprobar_correo_usuario_existente(correo, usuario);
    if (comprobar_usuario_existente.isEmpty  || (persona_correo == correo && persona_usuario ==usuario)) {
      
      String url_imagen = "";
      if (imagen != null) {
        url_imagen = await api_cloudinary.uploadFile(imagen);
      } else {
        url_imagen = persona_imagen;
      }
      String clave = encriptar(password);
      int response_statusCode = await model_persona.editar_usuario(
          persona_id.toString(),
          nombre,
          apellido,
          direccion,
          telefono,
          url_imagen,
          correo,
          usuario,
          clave);
      if (response_statusCode == 200) {
        persona_nombre = nombre;
        persona_apellido = apellido;
        persona_direccion = direccion;
        persona_telefono = telefono;
        persona_imagen = url_imagen;
        persona_correo = correo;
        persona_usuario = usuario;
        aviso("Datos Editados", context);
        Timer(Duration(milliseconds: 2000), () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyPerfil()));
        });
      }
      
      
    } else {
      aviso('Correo o usuario ya existentes', context);
    }

    
  }

  void redirreccionar_asignar_rol_persona(
      int id_persona, String nombre_apellido, BuildContext context) async {
    List datos_rol = await model_rol.seleccionar_roles();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AsignarRolPersona(
                  datos_rol: datos_rol,
                  nombre_apellido: nombre_apellido,
                  id_persona: id_persona,
                )));
  }

  void editar_rol_persona(
      int id_rol, int id_persona, BuildContext context) async {    
    int response_statusCode = await model_persona.asignar_rol(
        id_persona.toString(), id_rol.toString());
    List datos = await model_persona.select_todas_personas();
    if (response_statusCode == 200) {
      aviso("ROL ASIGNADO", context);
      
      Timer(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VisualizarTodaPersona(datos: datos,)));
      });
    }
  }

  void logout(BuildContext context) async {
    persona_id = 0;
    persona_nombre = "";
    persona_apellido = "";
    persona_direccion = "";
    persona_telefono = "";
    persona_correo = "";
    persona_imagen = "";
    persona_usuario = "";
    persona_rol = 0;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
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
