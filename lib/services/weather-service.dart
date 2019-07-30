import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_key.dart';

class WeatherService {

  String apiKey = ApiKey.weatherKey;

  Future<Map> getWeatherData(String lat, String lon) async{

//    var time = (DateTime.now().millisecondsSinceEpoch / 1000).round();
//    print(time);

    String url = "https://api.darksky.net/forecast/$apiKey/$lat,$lon?units=si";

    try{
      var response = await http.get(url);
      if(response.statusCode == 200){
        var jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse;
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