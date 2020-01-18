import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_key.dart';

class CityService {
  static String apiKey = ApiKey.geoKey;

  static Future<String> getCityName(double lat, double lon) async{

    //print("$lat, $lon");
//    String url = "https://geocode.xyz/$lat,$lon?geoit=json&auth=$apiKey";
    String url = "https://api.opencagedata.com/geocode/v1/json?q=${lat.toString()}+${lon.toString()}&key=$apiKey&language=fa";


    try{
      var response = await http.get(url);
     // print(response.body);
      if(response.statusCode == 200){
        var jsonResponse = await convert.jsonDecode(response.body);
        print(jsonResponse);
//        return jsonResponse["results"][0]["components"]["city"];

        if(jsonResponse["results"][0]["components"].containsKey("city")){
          return jsonResponse["results"][0]["components"]["city"];
        }else if(jsonResponse["results"][0]["components"].containsKey("village")){
          return jsonResponse["results"][0]["components"]["village"];
        }else if(jsonResponse["results"][0]["components"].containsKey("state_district")){
          return jsonResponse["results"][0]["components"]["state_district"];
        }else{
          return jsonResponse["results"][0]["components"]["country"];
        }


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

//    String url = "https://geocode.xyz/?locate=$location&auth=$apiKey&json=1";
    String url = "https://api.opencagedata.com/geocode/v1/json?q=$location&key=$apiKey&language=fa";
//    print("$lat, $lon");

    try{
      var response = await http.get(url);
//      print(response.body);
      if(response.statusCode == 200){
        var jsonResponse = await convert.jsonDecode(response.body);
//        print(jsonResponse);
        if(jsonResponse["results"].toString() == "[]"){
          print("//////////////////error : ");
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