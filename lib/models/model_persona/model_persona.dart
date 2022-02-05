import 'dart:convert';
import 'package:arriendo/models/constantes.dart';
import 'package:http/http.dart' as http;

class ModelPersona {
  Future<List> model_logIn(String usuario, String password) async {
    var url = ip_server + "login";
    final response = await http.post(url, body: {
      "usuario": usuario,
      "password": password,
    });
    var resultado = json.decode(response.body);
    if (resultado['data'] != null) {
      return resultado['data'];
    }
    return [];
  }

  Future<List> select_todas_personas() async {
    var url = ip_server + "personaselectall";
    final response = await http.post(url, body: {});
    var resultado = json.decode(response.body);
    if (resultado['data'] != null) {
      return resultado['data'];
    }
    return [];
  }

  Future<int> eliminar_persona(String id_persona) async {
    var url = ip_server + "personaeliminar";
    final response = await http.post(url, body: {
      "id": id_persona,
    });
    var resultado = json.decode(response.body);
    if (resultado['code'] != null) {
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }

  Future<int> editar_usuario(
      String persona_id,
      String nombre,
      String apellido,
      String direccion,
      String telefono,
      String imagen,
      String correo,
      String usuario,
      String password) async {
    var url = ip_server + "personaeditar";
    final response = await http.post(url, body: {
      "id": persona_id,
      "nombre": nombre,
      "apellido": apellido,
      "direccion": direccion,
      "telefono": telefono,
      "imagen": imagen,
      "correo": correo,
      "usuario": usuario,
      "password": password,
    });

    var resultado = json.decode(response.body);
    if (resultado['code'] != null) {
      if (int.parse(resultado['code'].toString()) == 200) {
        persona_nombre = nombre;
        persona_apellido = apellido;
        persona_direccion = direccion;
        persona_telefono = telefono;
        persona_imagen = imagen;
        persona_correo = correo;
        persona_usuario = usuario;
      }
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }

  Future<int> registro_usuario(
      String nombre,
      String apellido,
      String direccion,
      String telefono,
      String imagen,
      String correo,
      String usuario,
      String password) async {
    var url = ip_server + "personacrear";

    final response = await http.post(url, body: {
      "nombre": nombre,
      "apellido": apellido,
      "direccion": direccion,
      "telefono": telefono,
      "imagen": imagen,
      "correo": correo,
      "usuario": usuario,
      "password": password,
    });

    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }

  Future<int> asignar_rol(String id_persona, String rol_id) async {
    var url = ip_server + "personaasignarrol";
    final response = await http.post(url, body: {
      "per_rol": rol_id,
      "per_id": id_persona,
    });

    var resultado = json.decode(response.body);
    if(resultado['code']!=null){
      return int.parse(resultado['code'].toString());
    }
    return 404;
  }

  Future<List> comprobar_correo_usuario_existente(
      String per_correo, String per_usuario) async {
    var url = ip_server + "personacomprobarusuariocorreo";
    final response = await http.post(url, body: {
      "per_correo": per_correo,
      "per_usuario": per_usuario,
    });
    var resultado = json.decode(response.body);
    if (resultado['data'] != null) {
      return resultado['data'];
    }
    return [];
  }
}
