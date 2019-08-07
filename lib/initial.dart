import 'package:flutter/material.dart';
import 'package:hava_negar/pages/drawer_section.dart';
import 'package:hava_negar/pages/home_page.dart';
import 'package:hava_negar/services/city_service.dart';
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

  Future<void> _onRefresh() async {
    await _getWeatherData();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
        body: RefreshIndicator(
            child: HomePage(
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
              mainImage: HomePageInitialData.mainImage,
            ),
            onRefresh: _onRefresh),
        drawer: DrawerSection(
          isDarkMode: this.isDarkMode,
          onSwitchClicked: onDrawerSwitchClicked,
          day1: DrawerInitialData.day1,
          day2: DrawerInitialData.day2,
          day3: DrawerInitialData.day3,
          day4: DrawerInitialData.day4,
          lastUpdate: "${DrawerInitialData.lastUpdate}",
        ));
  }

  _getWeatherData() async {
//    print(this.weatherData);,
    //await LocationService.getLocation();
//    await CityService.getCityLocation(location: "جیرف");

    //print(DateTime.now().timeZoneOffset.inMinutes);
    this.weatherData = await WeatherService().getWeatherData(HomePageInitialData.latt, HomePageInitialData.longt);
    this.city = await CityService.getCityName(weatherData["latitude"], weatherData["longitude"]);
    //print(weatherData);
    //print(city);

    if (this.weatherData == null) {
      print("Error in Weather!!");
      return;
    } else if (this.city == null) {
      print("Error in City!!");
    } else {
      setState(() {
        this.currentData = this.weatherData["currently"];
        this.hourDara = this.weatherData["hourly"]["data"];
        this.todayData = this.weatherData["daily"]["data"][1];
        this.weekData = this.weatherData["daily"]["data"];

        DrawerInitialData.lastUpdate = DateTime.now().toLocal().hour.toString() + ":" + DateTime.now().toLocal().minute.toString();

        DrawerInitialData.day1 = {
          "icon": SelectIcon.icon[this.weekData[2]["icon"]],
          "week_number": ConvertTimestamp.convert(this.weekData[2]["time"]).weekday,
          "high_temp": (this.weekData[2]["temperatureHigh"]).round(),
          "low_temp": (this.weekData[2]["temperatureLow"]).round(),
        };

        DrawerInitialData.day2 = {
          "icon": SelectIcon.icon[this.weekData[3]["icon"]],
          "week_number": ConvertTimestamp.convert(this.weekData[3]["time"]).weekday,
          "high_temp": (this.weekData[3]["temperatureHigh"]).round(),
          "low_temp": (this.weekData[3]["temperatureLow"]).round(),
        };

        DrawerInitialData.day3 = {
          "icon": SelectIcon.icon[this.weekData[4]["icon"]],
          "week_number": ConvertTimestamp.convert(this.weekData[4]["time"]).weekday,
          "high_temp": (this.weekData[4]["temperatureHigh"]).round(),
          "low_temp": (this.weekData[4]["temperatureLow"]).round(),
        };

        DrawerInitialData.day4 = {
          "icon": SelectIcon.icon[this.weekData[5]["icon"]],
          "week_number": ConvertTimestamp.convert(this.weekData[5]["time"]).weekday,
          "high_temp": (this.weekData[5]["temperatureHigh"]).round(),
          "low_temp": (this.weekData[5]["temperatureLow"]).round(),
        };

        HomePageInitialData.cityName = this.city;
        HomePageInitialData.lowTemp = this.todayData["temperatureLow"].round().toString();
        HomePageInitialData.highTemp = this.todayData["temperatureHigh"].round().toString();
        HomePageInitialData.temperature = (this.currentData["temperature"]).round().toString();
        HomePageInitialData.wind = this.currentData["windSpeed"].toString();
        HomePageInitialData.weatherStatus = FarsiNames.weatherStatus[this.currentData["icon"]];
        HomePageInitialData.sunRise = (ConvertTimestamp.convert(this.todayData["sunriseTime"] + timezone.inSeconds).hour).toString() +
            ":" +
            (ConvertTimestamp.convert(this.todayData["sunriseTime"] + timezone.inSeconds).minute).toString();

        HomePageInitialData.sunSet = ConvertTimestamp.convert(this.todayData["sunsetTime"] + timezone.inSeconds).hour.toString() +
            ":" +
            ConvertTimestamp.convert(this.todayData["sunsetTime"] + timezone.inSeconds).minute.toString();
        HomePageInitialData.mainImage = SelectIcon.icon[this.currentData["icon"]];

        // int c = 1;
        // this.hourDara.forEach((value){
        //print("$c -> value: ${ConvertTimestamp.convert(value["time"])}");
        //   c++;
        // });

        //var time = (DateTime.now().millisecondsSinceEpoch / 1000).round();

        // print(this.weatherData);
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
