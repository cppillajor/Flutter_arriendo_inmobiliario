import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModelTipoArriendo{
  Future<List> obtenerTiposArriendo() async {
    var url = ip_server + "tipoinmuebleselect";
    final response = await http.post(url, body: {});
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<int> ingresar_tipo_inmueble(String nombre,String descripcion,String imagen) async {    
    
    var url = ip_server + "tipoinmueblecrear";

    final response = await http.post(url, body: {
      "tin_nombre": nombre,
      "tin_descripcion": descripcion,
      "tin_imagen":imagen,
    });
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
  Future<int> eliminar_tipo_inmueble(String id_tipo_inmueble) async {   
    
    var url = ip_server + "tipoinmuebleeliminar";
    final response = await http.post(url, body: {
      "id":id_tipo_inmueble,      
    });
    
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
  Future<int> editar_tipo_inmueble(String id_tipo_inmueble,String nombre, String descripcion,String imagen) async {    
    
    var url = ip_server + "tipoinmuebleeditar";    
    

    final response = await http.post(url, body: {
      "id":id_tipo_inmueble,
      "tin_nombre": nombre,
      "tin_descripcion": descripcion,
      "tin_imagen": imagen,
      
    });   
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
}