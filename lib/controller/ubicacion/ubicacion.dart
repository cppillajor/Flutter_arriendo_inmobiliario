
import 'package:geolocator/geolocator.dart';
class Ubicacion{
  Future<Position> determinePosition() async {
  LocationPermission permission;
  Position  retornar;
    
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return retornar;
  }
  
  
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse 
        ) {
      return retornar;
    }
  } 
  
  
  return await Geolocator.getCurrentPosition();
}
}