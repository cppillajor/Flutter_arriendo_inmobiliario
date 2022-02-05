import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModelSolicitudRol{
  Future<int> insert_solicitud_rol(String sr_id_persona,String sr_descripcion) async {
    var url = ip_server + "solicitudrolcrear";    
    final response = await http.post(url, body: {
      "sr_id_persona":sr_id_persona,
      "sr_descripcion":sr_descripcion   
    });
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
  Future<List> select_solicitud_rol() async {
    var url = ip_server + "solicitudrolselect";
    final response = await http.post(url, body: {});
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<List> comprobar_solicitud_rol_id_persona(String sr_id_persona) async {
    var url = ip_server + "solicitudrolcomprobarsolicitud";
    final response = await http.post(url, body: {
      "sr_id_persona":sr_id_persona
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<int> eliminar_solicitud_rol(String sr_id) async {
    var url = ip_server + "solicitudroleliminar";
    final response = await http.post(url, body: {
      "sr_id":sr_id
    });
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
}