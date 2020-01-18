import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hava_negar/pages/select_city.dart';
import 'package:hava_negar/services/check_internet_connection.dart';
import 'package:hava_negar/utility/initial_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../initial.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> anim;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    animController = new AnimationController(vsync: this, duration: Duration(seconds: 3));
    anim = Tween(begin: 0.0, end: 3.14).animate(CurvedAnimation(
      parent: animController,
      curve: Curves.linear,
    ));
    animController.addListener(() {
      if (animController.isCompleted) {
        animController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // check internet connection
    // check and get data from splash Screen
    // if shared is empty goto select city page
    _init();

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      body: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.white, Colors.yellow[600]], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: AnimatedBuilder(
              animation: anim,
              builder: (c, ch) {
                return Transform.rotate(
                  angle: anim.value,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/splash_image.svg",
                      width: screenSize.width * .65,
                    ),
                  ),
                );
              })),
    );
  }

  // in this section we most check shared if have data then check internet
  // and go but if not any data and not internet connection most show a alert and not
  // go to the screen

  // in shared pref most initial the initial_data.dart file

  _init() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getKeys().isEmpty) {
      if (await CheckInternetConnection.check()) {

        await animController.forward();
//        await Future.delayed(Duration(seconds: 3));
//        animController.dispose();
        // goto select city page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: SelectCity())));
      } else {
        scaffoldKey.currentState.showSnackBar(
          SnackBar(
            duration: Duration(seconds: 25),
            content: GestureDetector(
              child: Text(
                "اینترنت متصل نیست! تلاش دوباره...",
                style: TextStyle(fontFamily: "Vazir"),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                scaffoldKey.currentState.removeCurrentSnackBar();
                _init();
              },
            ),
          ),
        );
      }
    } else {
      // set data to initial data
      HomePageInitialData.sunRise = prefs.getString("sunRise");
      HomePageInitialData.sunSet = prefs.getString("sunSet");
      HomePageInitialData.longt = prefs.getString("longt");
      HomePageInitialData.latt = prefs.getString("latt");
      HomePageInitialData.cityName = prefs.getString("cityName");
      HomePageInitialData.lowTemp = prefs.getString("lowTemp");
      HomePageInitialData.highTemp = prefs.getString("highTemp");
      HomePageInitialData.temperature = prefs.getString("temperature");
      HomePageInitialData.wind = prefs.getString("wind");
      HomePageInitialData.weatherStatus = prefs.getString("weatherStatus");
      HomePageInitialData.mainImage = prefs.getString("mainImage");

      HomePageInitialData.isDarkMode = prefs.getBool("isDarkMode");

      DrawerInitialData.lastUpdate = prefs.getString("lastUpdate");
      DrawerInitialData.day1 = {
        "icon": prefs.getStringList("day1")[0],
        "week_number": int.parse(prefs.getStringList("day1")[1]),
        "high_temp": int.parse(prefs.getStringList("day1")[1]),
        "low_temp": int.parse(prefs.getStringList("day1")[1]),
      };

      DrawerInitialData.day2 = {
        "icon": prefs.getStringList("day2")[0],
        "week_number": int.parse(prefs.getStringList("day2")[1]),
        "high_temp": int.parse(prefs.getStringList("day2")[1]),
        "low_temp": int.parse(prefs.getStringList("day2")[1]),
      };

      DrawerInitialData.day3 = {
        "icon": prefs.getStringList("day3")[0],
        "week_number": int.parse(prefs.getStringList("day3")[1]),
        "high_temp": int.parse(prefs.getStringList("day3")[1]),
        "low_temp": int.parse(prefs.getStringList("day3")[1]),
      };

      DrawerInitialData.day4 = {
        "icon": prefs.getStringList("day4")[0],
        "week_number": int.parse(prefs.getStringList("day4")[1]),
        "high_temp": int.parse(prefs.getStringList("day4")[1]),
        "low_temp": int.parse(prefs.getStringList("day4")[1]),
      };

      animController.forward();

      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Initial()));
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}
