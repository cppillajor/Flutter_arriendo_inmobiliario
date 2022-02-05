import 'dart:async';

import 'package:arriendo/models/model_notificacion/model_notificacion.dart';
import 'package:arriendo/pages/notificacion/Visualizar_notificacion.dart';
import 'package:arriendo/pages/notificacion/visualizar_perfil_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControllerNotificacion{
  ModelNotificacion model_notificacion = new ModelNotificacion();
  void visualizar_notificacion(BuildContext context)async{
    List datos = await model_notificacion.select_notificacion_id_persona();
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisualizarNotificacion(datos: datos)));

  }
  void eliminar_notificacion(int no_id,BuildContext context)async{
    int statusCode = await model_notificacion.eliminar_notificacion(no_id.toString());
    List datos = await model_notificacion.select_notificacion_id_persona();
    if(statusCode==200){
      aviso("Eliminado", context);
      Timer(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VisualizarNotificacion(datos: datos)));
      });
    }

  }

  void vizualizar_datos_del_arrendatario(int id_persona_arrendatario,BuildContext context)async{
    List datos = await model_notificacion.select_una_persona_por_id(id_persona_arrendatario.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => PerfilUsuario(datos: datos,titulo: 'Datos Arrendatario',)));

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