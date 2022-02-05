import 'dart:convert';
import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;
class ModelInmueble{
  Future<List> obtenertiposinmueble(String id) async {
    var url=ip_server+"inmuebleselectseguntipoinmueble";
    final response = await http.post(url, body: {
      "id": id,
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<List> obtener_inmuebles_segun_id_persona() async {
    var url=ip_server+"inmuebleselectsegunidpersona";
    final response = await http.post(url, body: {
      "id": persona_id.toString(),
    });
    var resultado = json.decode(response.body); 
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }
  Future<List> obtener_inmueble_segun_id_inmueble(String id) async {
    var url = ip_server + "inmuebleshow";
    final response = await http.post(url, body: {
      "id": id,
    });
    var resultado = json.decode(response.body);
    if(resultado['data']!=null){
      return resultado['data'];
    }
    return [];
  }

  Future<int> actualizar_inmueble(
      String id_inmueble,
      String descripcion,
      String direccion,
      String num_cuarto,
      String num_bano,
      String num_cocina,
      String num_parqueadero,
      String num_sala,
      String precio,
      String tamano,
      String id_tipo_inmueble,
      String inmueble_amoblado,
      String contrato,
      String imagen,
      String latitud,
      String longitud
  ) async {    
    
    var url = ip_server + "inmuebleeditar";
    
    final response = await http.post(url, body: {
      "in_id":id_inmueble,
      "in_id_tipo_inmueble":id_tipo_inmueble.toString(),
      "in_id_persona": persona_id.toString(),
      "in_descripcion":descripcion,
      "in_direccion":direccion,
      "in_num_cuarto":num_cuarto,
      "in_num_baño":num_bano,
      "in_num_sala":num_sala,
      "in_num_cocina":num_cocina,
      "in_num_parqueadero":num_parqueadero,
      "in_inmueble_amoblado":inmueble_amoblado,
      "in_tamaño":tamano,
      "in_contrato": contrato,
      "in_precio_inmueble":precio,
      "in_imagen":imagen,
      "in_latitud":latitud,
      "in_longitud":longitud      
    });   
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
  Future<int> ingresar_inmueble(      
      String descripcion,
      String direccion,
      String num_cuarto,
      String num_bano,
      String num_cocina,
      String num_parqueadero,
      String num_sala,
      String precio,
      String tamano,
      String id_tipo_inmueble,
      String inmueble_amoblado,
      String contrato,
      String imagen,
      String latitud,
      String longitud
  ) async {    
    var url = ip_server + "inmueblecrear"; 
    final response = await http.post(url, body: {
      "in_id_tipo_inmueble":id_tipo_inmueble,
      "in_id_persona": persona_id.toString(),
      "in_descripcion":descripcion,
      "in_direccion":direccion,
      "in_num_cuarto":num_cuarto,
      "in_num_baño":num_bano,
      "in_num_sala":num_sala,
      "in_num_cocina":num_cocina,
      "in_num_parqueadero":num_parqueadero,
      "in_inmueble_amoblado":inmueble_amoblado,
      "in_tamaño":tamano,
      "in_contrato":contrato,
      "in_precio_inmueble":precio,
      "in_imagen":imagen ,     
      "in_latitud":latitud,
      "in_longitud":longitud
    });   
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }
  Future<int> eliminar_inmueble(String id_inmueble) async{
    var url = ip_server + "inmuebleeliminar";
    final response = await http.post(url, body: {
      "in_id":id_inmueble,     
    });
    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }



}