import 'dart:async';

import 'package:arriendo/models/model_en_arriendo/model_en_arriendo.dart';
import 'package:arriendo/models/model_tipo_inmueble/model_tipo_arriendo.dart';
import 'package:arriendo/pages/En%20arriendo/Visualizar_enarriendo.dart';
import 'package:arriendo/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControllerEnArriendo{
  ModelEnArriendo model_en_arriendo = new ModelEnArriendo();
  ModelTipoArriendo model_tipo_arriendo = new ModelTipoArriendo();
  void en_arriendo(int id_persona_solicitante,int id_inmueble,BuildContext context)async{
    int response_statusCode = await model_en_arriendo.en_arreindo(id_persona_solicitante.toString(), id_inmueble.toString());
    List datos = await model_tipo_arriendo.obtenerTiposArriendo();
    
    if(response_statusCode==200){
      aviso("Arrendado", context);
      Timer(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(datos:datos ,)));
      });

    }
    
  }
  void visualizar_en_arriendo(BuildContext context)async{
    List datos = await model_en_arriendo.visualizar_en_arriendo();
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisualizarEnArriendo(datos:datos)));

  }

  void eliminar_en_arreindo(int ea_id,BuildContext context)async{
    
    int response_statusCode = await model_en_arriendo.eliminar_en_arriendo(ea_id.toString());
    List datos = await model_en_arriendo.visualizar_en_arriendo();
    if(response_statusCode==200){
      aviso("Eliminado", context);
      Timer(Duration(milliseconds: 2000), ()  {
        
        Navigator.pop(context);
        Navigator.pop(context);
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VisualizarEnArriendo(datos:datos)));
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