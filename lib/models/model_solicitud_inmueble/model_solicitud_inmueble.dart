import 'dart:convert';
import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;

class ModelSolicitudInmueble {
  Future<List> interesados_inmueble(String id_inmueble) async {
    var url = ip_server + "solicitudarriendointeresadosinmueble";
    final response = await http.post(url,body:{
      "id": id_inmueble
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }

  Future<int> solicitar_inmueble(String id_inmueble,String id_persona_solicitante ,String id_persona_arrendador) async {    
    
    var url = ip_server + "solicitudarriendocrear";
    final response = await http.post(url, body: {
      "sa_id_inmueble":id_inmueble, 
      "sa_id_persona_solicitante":id_persona_solicitante,
      "sa_id_persona_arrendatario":id_persona_arrendador,      
    });
    
    var resultado = json.decode(response.body);
    
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
  Future<List> comprobar_solicitud_repetida(String sa_id_persona_solicitante,String sa_id_inmueble) async {
    var url = ip_server + "solicitudarriendocomprobarsolicitudrepetida";
    final response = await http.post(url,body:{
      "sa_id_persona_solicitante": sa_id_persona_solicitante,
      "sa_id_inmueble":sa_id_inmueble,
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
}
