import 'package:location/location.dart';

class LocationService {
  static Future<Map> getLocation() async {
    var location = new Location();

    LocationData currentLocation;

    try {
      currentLocation = await location.getLocation();
      print("----------------------" + currentLocation.latitude.toString());
      return {
        "lat" : "",
        "lon" : "",
      };
    } catch (e) {
      print(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
      return null;
    }
  }

  static Future<bool> getPermission() async{
    return await Location().requestPermission();
  }

  static Future<bool> hasPermission() async{
    return await Location().hasPermission();
  }

}
