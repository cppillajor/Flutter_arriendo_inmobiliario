import 'dart:convert';
import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;
class ModelEnArriendo{
  Future<int> en_arreindo(String id_persona_solicitante,String id_inmueble) async {    
    int response_statusCode=0;
    var url = ip_server + "enarriendocrear";
    final response = await http.post(url, body: {
      "ea_id_persona_solicitante":id_persona_solicitante.toString(), 
      "ea_id_persona_arrendatario":persona_id.toString(),
      "ea_id_inmueble":id_inmueble.toString()     
    });
    var resultado = json.decode(response.body);
    var url2 = ip_server + "notificacioncrear";
    final response2 = await http.post(url2, body: {
      "no_id_persona_solicitante":id_persona_solicitante.toString(), 
      "no_descripcion":"Se acepto la solicitud de arriendo del inmueble",
      "no_id_persona_arrendatario":persona_id.toString(),
      "no_id_inmueble":id_inmueble.toString()     
    });
    var resultado2 = json.decode(response2.body);
    var url3 = ip_server + "inmuebleeliminar";
    final response3 = await http.post(url3, body: {
      "in_id":id_inmueble.toString(),     
    });
    var resultado3 = json.decode(response3.body);
    if (resultado['code'] == null && resultado2['code'] == null && resultado3['code'] == null) {      
      return 0;
    } 
    if (resultado['code'] == 200 && resultado2['code'] == 200 && resultado3['code'] == 200) {      
      response_statusCode=200;
    }else{
      response_statusCode=0;
    }
    return response_statusCode;
  }

  Future<List> visualizar_en_arriendo()async{    
    var url = ip_server + "enarriendoshow";    
    final response = await http.post(url, body: {
      "ea_id_persona_arrendatario":persona_id.toString()
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<int> eliminar_en_arriendo(String ea_id)async{    
    var url = ip_server + "enarriendoeliminar";
    final response = await http.post(url, body: {
      "ea_id":ea_id
    });    
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
}