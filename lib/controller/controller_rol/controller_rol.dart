import 'package:arriendo/models/model_rol/model_rol.dart';
import 'package:arriendo/pages/rol/visualizar_roles.dart';
import 'package:flutter/material.dart';

class ControllerRol{
  ModelRol model_rol= new ModelRol();
  void redireccionar_visualizar_roles(BuildContext context)async{
    List datos = await model_rol.seleccionar_roles();
    Navigator.push(context, MaterialPageRoute(builder: (context) => VisualizarRol(datos: datos,)));

  }

}