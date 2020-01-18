
import 'package:location/location.dart';

class LocationService {


  static getLocation() async{
        var location = new Location();

  LocationData currentLocation ;

      print(await location.hasPermission());
      try {
        currentLocation = await location.getLocation();
        print("----------------------" + currentLocation.latitude.toString());
      } catch (e) {
        print(e.toString());
        if (e.code == 'PERMISSION_DENIED') {
          print('Permission denied');
        }
        currentLocation = null;
      }
  }
}