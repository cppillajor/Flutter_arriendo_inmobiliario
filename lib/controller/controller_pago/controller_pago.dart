import 'dart:async';
import 'dart:io';


import 'package:arriendo/models/model_pago/model_pago.dart';
import 'package:arriendo/pages/pago/agregarpago.dart';
import 'package:arriendo/pages/pago/editarpago.dart';
import 'package:arriendo/pages/pago/listapagos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ControllerPago{
  ModelPago model_pago = new ModelPago();
  void redireccionar_agregar_pago(BuildContext context,int id_inmueble){    
    Navigator.push(context, MaterialPageRoute(builder: (context) => AgregarPago(id_inmueble:id_inmueble ,) ));
  }
  void redireccionar_lista_pago(BuildContext context,int id_inmueble)async{
    List lista_datos = await model_pago.obtenerlistapago(id_inmueble.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => Visualizarlistapagos(datos: lista_datos,id_inmueble: id_inmueble,) ));
  }


  void ingresar_lista_pago(BuildContext context,int id_inmueble ,DateTime ipm_fecha_pago, String ipm_valor_mensual)async{
    String fecha = ipm_fecha_pago.toString();
    int response_statusCode= await model_pago.insert_lista_pagos(id_inmueble.toString(), fecha, ipm_valor_mensual);
    if(response_statusCode == 200){
      Navigator.pop(context);
      List lista_datos = await model_pago.obtenerlistapago(id_inmueble.toString());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Visualizarlistapagos(datos: lista_datos,id_inmueble: id_inmueble,) ));
    }
  }
  void redireccionar_actualizar_pago(BuildContext context,int id_inmueble,int ipm_id ,String ipm_fecha_pago, String ipm_valor_mensual){    
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditarPago(id_inmueble: id_inmueble,ipm_id: ipm_id,fecha: ipm_fecha_pago,valor: ipm_valor_mensual,) ));
  }

  void actualizar_lista_pago(BuildContext context,int id_inmueble,int ipm_id  ,DateTime ipm_fecha_pago, String ipm_valor_mensual)async{
    String fecha = ipm_fecha_pago.toString();
    int response_statusCode= await model_pago.actualizar_lista_pago(ipm_id.toString(), fecha, ipm_valor_mensual);
    if(response_statusCode == 200){
      Navigator.pop(context);
      List lista_datos = await model_pago.obtenerlistapago(id_inmueble.toString());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Visualizarlistapagos(datos: lista_datos,id_inmueble: id_inmueble,) ));
    }
  }
}