
import 'package:location/location.dart';

class LocationService {
  var location = new Location();

  var currentLocation ;

  getLocation() async{
      print(await this.location.hasPermission());
      try {
        print(await this.location.getLocation());
        print("try");
      } catch (e) {
        print(e.toString());
        if (e.code == 'PERMISSION_DENIED') {
          print('Permission denied');
        }
        currentLocation = null;
      }
  }
}