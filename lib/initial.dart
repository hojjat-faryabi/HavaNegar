import 'package:flutter/material.dart';
import 'package:hava_negar/pages/drawer_section.dart';
import 'package:hava_negar/pages/home_page.dart';
import 'package:hava_negar/services/get_city_name.dart';
import 'package:hava_negar/services/weather-service.dart';
import 'package:hava_negar/utility/convert_timestanp.dart';
import 'package:hava_negar/utility/app_language.dart';
import 'package:hava_negar/utility/initial_data.dart';
import 'package:hava_negar/utility/what_icon.dart';

class Initial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitialState();
}

class InitialState extends State<Initial> {
  bool isDarkMode;

  Map weatherData;
  Map currentData;
  List hourDara;
  Map todayData;
  List weekData;
  String city;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var timezone = DateTime.now().timeZoneOffset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDarkMode = HomePageInitialData.isDarkMode;
    _getWeatherData();
  }

  Future<void> _onRefresh() async{
    await _getWeatherData();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: RefreshIndicator(
            child: weatherData == null
                ? HomePage(
              scaffoldKey: scaffoldKey,
              isDarkMode: this.isDarkMode,
              cityName: HomePageInitialData.cityName,
              lowTemp: HomePageInitialData.lowTemp,
              highTemp: HomePageInitialData.highTemp,
              sunRise: HomePageInitialData.sunRise,
              weatherStatus: HomePageInitialData.weatherStatus,
              wind: HomePageInitialData.wind,
              temperature: HomePageInitialData.temperature,
              sunSet: HomePageInitialData.sunSet,
              mainImage: "big_sun.svg",
            )
                : HomePage(
              mainImage: SelectIcon.icon[this.currentData["icon"]],
              isDarkMode: this.isDarkMode,
              temperature: (this.currentData["temperature"]).round().toString(),
              scaffoldKey: scaffoldKey,
              wind: this.currentData["windSpeed"].toString(),
              weatherStatus: FarsiNames.weatherStatus[this.currentData["icon"]],
              highTemp: this.todayData["temperatureHigh"].round().toString(),
              lowTemp: this.todayData["temperatureLow"].round().toString(),
              cityName: this.city,
              sunRise: (ConvertTimestamp.convert(this.todayData["sunriseTime"] + timezone.inSeconds).hour).toString() +
                  ":" +
                  (ConvertTimestamp.convert(this.todayData["sunriseTime"] + timezone.inSeconds).minute).toString(),
              sunSet: ConvertTimestamp.convert(this.todayData["sunsetTime"] + timezone.inSeconds).hour.toString() +
                  ":" +
                  ConvertTimestamp.convert(this.todayData["sunsetTime"] + timezone.inSeconds).minute.toString(),
            ),
            onRefresh: _onRefresh
        ),
        drawer: DrawerSection(
          isDarkMode: this.isDarkMode,
          onSwitchClicked: onDrawerSwitchClicked,
          day1: DrawerInitialData.day1,
          day2: DrawerInitialData.day2,
          day3: DrawerInitialData.day3,
          day4: DrawerInitialData.day4,
          lastUpdate: "${DrawerInitialData.lastUpdate["clock"] + FarsiNames.halfDay[DrawerInitialData.lastUpdate["am_pm"]]}",
        )
    );
  }

  _getWeatherData() async {
//    print(this.weatherData);,
    print(DateTime.now().timeZoneOffset.inMinutes);
    this.weatherData = await WeatherService().getWeatherData("30.2924", "57.0646");
    this.city = await CityName().getCityName(weatherData["latitude"], weatherData["longitude"]);

    if (this.weatherData == null) {
      print("Error in Weather!!");
      return;
    } else if (this.city == null) {
      print("Error in City!!");
    } else {
      setState(() {
        this.currentData = this.weatherData["currently"];
        this.hourDara = this.weatherData["hourly"]["data"];
        this.todayData = this.weatherData["daily"]["data"][0];
        this.weekData = this.weatherData["daily"]["data"];


        int c = 1;
        this.hourDara.forEach((value){
          print("$c -> value: ${ConvertTimestamp.convert(value["time"])}");
          c++;
        });

        var time = (DateTime.now().millisecondsSinceEpoch / 1000).round();


        print(this.weatherData);
      });
    }

    //int times = this.weatherData["currently"]["time"];
    // print(DateTime.fromMillisecondsSinceEpoch(times * 1000).toUtc());
//    print(this.weatherData);
  }

  onDrawerSwitchClicked(bool value) {
    setState(() {
      if (this.isDarkMode)
        this.isDarkMode = false;
      else
        this.isDarkMode = true;
    });
  }
}
