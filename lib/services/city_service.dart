import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_key.dart';

class CityService {
  static String apiKey = ApiKey.geoKey;

  static Future<String> getCityName(double lat, double lon) async{

    String url = "https://geocode.xyz/$lat,$lon?geoit=json&auth=$apiKey";
    //print("$lat, $lon");

    try{
      var response = await http.get(url);
      //print(response.body);
      if(response.statusCode == 200){
        var jsonResponse = await convert.jsonDecode(response.body);
        // most correct it !! in other city !!
        return jsonResponse["osmtags"]["name"];
      }else{
        print("Request failed with status: ${response.statusCode}.");
        return null;
      }

    }catch (e){
      print(e.toString());
      return null;
    }


  }

  static Future<Map> getCityLocation({String location,}) async{

    String url = "https://geocode.xyz/?locate=$location&auth=$apiKey&json=1";
//    print("$lat, $lon");

    try{
      var response = await http.get(url);
//      print(response.body);
      if(response.statusCode == 200){
        var jsonResponse = await convert.jsonDecode(response.body);
        //"longt"
        //print(jsonResponse["error"]);
        if(jsonResponse["error"] != null){
          print("//////////////////error : " + jsonResponse["error"]);
          return null;
        }else{
          return jsonResponse;
         // print(jsonResponse);

        }
        //return jsonResponse["city"];
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