import 'dart:convert';
import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;
class ModelNotificacion{
  Future<List> select_notificacion_id_persona() async {
    var url = ip_server + "notificacionseleccionarsegunidpersona";
    final response = await http.post(url, body: {
      "no_id_persona_solicitante":persona_id.toString()
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<List> select_una_persona_por_id(String id_persona) async {
    var url = ip_server + "personashow";
    final response = await http.post(url, body: {
      "per_id": id_persona,
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<int> eliminar_notificacion(String no_id) async {
    var url = ip_server + "notificacioneliminar";
    final response = await http.post(url, body: {
      "no_id":no_id
    });
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }

}