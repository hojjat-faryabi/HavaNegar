
import 'package:location/location.dart';

class LocationService {
  var location = new Location();

  LocationData currentLocation ;

  getLocation() async{
      print(await this.location.hasPermission());
      try {
        this.currentLocation = await this.location.getLocation();
        print(this.currentLocation.latitude);
      } catch (e) {
        print(e.toString());
        if (e.code == 'PERMISSION_DENIED') {
          print('Permission denied');
        }
        currentLocation = null;
      }
  }
}