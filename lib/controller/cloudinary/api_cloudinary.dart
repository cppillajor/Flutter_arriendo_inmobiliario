import 'dart:io';
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class ApiCloudinary{
  Uri apiUrl = Uri.parse('https://api.cloudinary.com/v1_1/dlyt0yjxb/image/upload?upload_preset=ig4taoeb');

  Future<String> uploadFile(File archivo) async {
    final mimeTypeData = lookupMimeType(archivo.path).split('/');
    final archivoUploadRequest = http.MultipartRequest('POST', apiUrl);
    final file = await http.MultipartFile.fromPath('file', archivo.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));    
    archivoUploadRequest.files.add(file);

    try {
      final streamedResponse = await archivoUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final responseData = json.decode(response.body);
      return responseData['secure_url'];
    } catch (e) {      
      return null;
    }
  }
}