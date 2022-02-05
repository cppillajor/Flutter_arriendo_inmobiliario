import 'dart:convert';
import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;
class ModelGaleria{

  Future<List> obtenergaleria(String id_inmueble) async {
    var url = ip_server + "galeriasegunidinmueble";
    final response = await http.post(url, body: {
      "gal_id": id_inmueble,
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<int> insert_galeria(String gal_id_inmueble,String gal_imagen) async {
    var url = ip_server + "galeriacrear";
    final response = await http.post(url, body: {
      "gal_imagen":gal_imagen,
      "gal_id_inmueble":gal_id_inmueble,
    });    
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
  Future<int> eliminar_foto_galeria(String gal_id) async {
    var url = ip_server + "galeriaeliminar";
    final response = await http.post(url, body: {
      "gal_id":gal_id,      
    });    
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
}