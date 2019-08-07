import 'dart:io';

import 'package:connectivity/connectivity.dart';

class CheckInternetConnection {

  // true means connected
  // false means disconnected
  static Future<bool> check() async{
//    try {
//      final result = await InternetAddress.lookup('google.com');
//      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        return true;
//      }else{
//        return false;
//      }
//    } on SocketException catch (_) {
//      print('not connected');
//      return false;
//    }

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

}