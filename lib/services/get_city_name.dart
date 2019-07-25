import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_key.dart';

class CityName {

  String apiKey = ApiKey.geoKey;

  Future<String> getCityName(double lat, double lon) async{

    String url = "https://geocode.xyz/$lat,$lon?geoit=json&auth=$apiKey";
//    print("$lat, $lon");

    try{
      var response = await http.get(url);
//      print(response.body);
      if(response.statusCode == 200){
        var jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse["city"];
      }else{
        print("Request failed with status: ${response.statusCode}.");
        return null;
      }

    }catch (e){
      print(e.toString());
      return null;
    }


  }


}