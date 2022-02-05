import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModelRol{
  Future<List> seleccionar_roles() async {
    var url = ip_server + "rol";
    final response = await http.post(url, body: {});
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
}