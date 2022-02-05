import 'dart:async';

import 'package:arriendo/models/constantes.dart';
import 'package:arriendo/models/model_inmueble/model_inmueble.dart';
import 'package:arriendo/models/model_solicitud_inmueble/model_solicitud_inmueble.dart';
import 'package:arriendo/pages/detalle_inmueble.dart';
import 'package:arriendo/pages/inmueble/interesados_inmueble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ControllerSolicitudInmueble{
  ModelSolicitudInmueble model_solicitud_inmueble = new ModelSolicitudInmueble();
  ModelInmueble model_inmueble = new ModelInmueble();
  void enviar_datos_interesados_inmueble(int id_inmueble,BuildContext context)async{
    List datos = await model_solicitud_inmueble.interesados_inmueble(id_inmueble.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => InteresadosInmueble(datos: datos,)));
  }
  void solicitar_inmueble(int id_inmueble, int id_persona_solicitante, int id_persona_arrendador,BuildContext context)async{
    List datos = await model_solicitud_inmueble.comprobar_solicitud_repetida(id_persona_solicitante.toString(), id_inmueble.toString());
    
    if(datos.isEmpty){
      
      int status_code = await model_solicitud_inmueble.solicitar_inmueble(id_inmueble.toString(), id_persona_solicitante.toString(), id_persona_arrendador.toString());
      if(status_code==200){
        aviso("Solicitud enviada con exito", context);  
      }else{
        aviso("Solicitud No Enviada", context);
      }
    }else{
      aviso("Usted ya envió una solicitud anteriormente", context); 
    }
        
    
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