import 'dart:async';

import 'package:arriendo/models/model_solicitud_rol/model_solicitud_rol.dart';
import 'package:arriendo/pages/solicitud_rol/Visualizar_solicitud_rol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControllerSolicitudRol {
  ModelSolicitudRol model_solicitud_rol = new ModelSolicitudRol();
  void insert_solicitud_rol(int sr_id_persona, BuildContext context) async {
    String sr_descripcion = "Solicito ser Arrendatario";
    List datos = await model_solicitud_rol
        .comprobar_solicitud_rol_id_persona(sr_id_persona.toString());
    if (datos.isEmpty) {
      int statusCode = await model_solicitud_rol.insert_solicitud_rol(
          sr_id_persona.toString(), sr_descripcion);
      if (statusCode == 200) {
        aviso("Solicitud Enviada", context);
        Timer(Duration(milliseconds: 2000), () {
          Navigator.pop(context);
        });
      }
    } else {
      aviso('Usted ya envio una solicitud', context);
    }
  }

  void select_solicitud_rol(BuildContext context) async {
    List datos = await model_solicitud_rol.select_solicitud_rol();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VisualizarSolicitudRol(
                  datos: datos,
                )));
  }

  void eliminar_solicitud_rol(int sr_id, BuildContext context) async {
    int statusCode = await model_solicitud_rol.eliminar_solicitud_rol(sr_id.toString());
    List datos = await model_solicitud_rol.select_solicitud_rol();
    if (statusCode == 200) {
      aviso("Eliminado con exito", context);
      Timer(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => VisualizarSolicitudRol(datos: datos,)));
      });
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
