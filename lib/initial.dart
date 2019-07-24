import 'package:flutter/material.dart';
import 'package:hava_negar/pages/drawer_section.dart';
import 'package:hava_negar/pages/home_page.dart';
import 'package:hava_negar/services/get_city_name.dart';
import 'package:hava_negar/services/weather-service.dart';
import 'package:hava_negar/utility/convert_timestanp.dart';

class Initial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitialState();
}

class InitialState extends State<Initial> {
  Map weatherData;
  Map currentData;
  Map hourDara;
  Map todayData;
  List weekData;
  String city;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var timezone = DateTime.now().timeZoneOffset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: weatherData == null
          ? HomePage(scaffoldKey: scaffoldKey,)
          : HomePage(
        temperature: (this.currentData["temperature"]).round().toString(),
        scaffoldKey: scaffoldKey,
        wind: this.currentData["windSpeed"].toString(),
        weatherStatus: this.currentData["summary"],
        highTemp: this.todayData["temperatureHigh"].round().toString(),
        lowTemp: this.todayData["temperatureLow"].round().toString(),
        cityName: this.city,
        sunRise: (ConvertTimestamp().convert(this.todayData["sunriseTime"] + timezone.inSeconds).hour).toString() +
            ":" +
            (ConvertTimestamp().convert(this.todayData["sunriseTime"] + timezone.inSeconds).minute).toString(),
        sunSet: ConvertTimestamp().convert(this.todayData["sunsetTime"] + timezone.inSeconds).hour.toString() +
            ":" +
            ConvertTimestamp().convert(this.todayData["sunsetTime"] + timezone.inSeconds).minute.toString(),
      ),
      drawer: DrawerSection()
    );
  }

  _getWeatherData() async {
//    print(this.weatherData);
    print(DateTime.now().timeZoneOffset.inMinutes);
    this.weatherData = await WeatherService().getWeatherData("30.258033", "57.103863");
    this.city = await CityName().getCityName(weatherData["latitude"], weatherData["longitude"]);

    if(this.weatherData == null){
      print("Error in Weather!!");
      return;
    }else if(this.city == null){
      print("Error in City!!");
    }else{
      setState(() {
        this.currentData = this.weatherData["currently"];
        this.hourDara = this.weatherData["hourly"];
        this.todayData = this.weatherData["daily"]["data"][0];
        this.weekData = this.weatherData["daily"]["data"];
        print(this.weatherData);
      });
    }


    //int times = this.weatherData["currently"]["time"];
    // print(DateTime.fromMillisecondsSinceEpoch(times * 1000).toUtc());
//    print(this.weatherData);
  }
}
