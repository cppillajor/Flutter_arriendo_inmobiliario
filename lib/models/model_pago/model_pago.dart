import 'dart:convert';
import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;
class ModelPago{

  Future<List> obtenerlistapago(String id_inmueble) async {
    var url = ip_server + "inmueblepagomensualsegunidinmueble";
    final response = await http.post(url, body: {
      "in_id": id_inmueble,
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<int> insert_lista_pagos(String id_inmueble ,String ipm_fecha_pago, String ipm_valor_mensual) async {
    var url = ip_server + "inmueblepagomensualcrear";
    final response = await http.post(url, body: {
      "in_id":id_inmueble,
      "ipm_fecha_pago":ipm_fecha_pago,
      "ipm_valor_mensual":ipm_valor_mensual,
    });    
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
  Future<int> actualizar_lista_pago(String ipm_id  ,String ipm_fecha_pago, String ipm_valor_mensual) async {
    var url = ip_server + "inmueblepagomensualeditar";
    final response = await http.post(url, body: {
      "ipm_id":ipm_id ,
      "ipm_fecha_pago":ipm_fecha_pago,
      "ipm_valor_mensual":ipm_valor_mensual,
    });    
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
}