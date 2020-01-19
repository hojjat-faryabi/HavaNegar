import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hava_negar/initial.dart';
import 'package:hava_negar/pages/select_city.dart';
import 'package:hava_negar/services/location_service.dart';
import 'package:hava_negar/services/weather-service.dart';
import 'package:hava_negar/utility/initial_data.dart';

class HomePage extends StatelessWidget {
  String cityName, highTemp, lowTemp, temperature, weatherStatus;
  String sunRise, sunSet, wind;
  var scaffoldKey;

  BuildContext context;

  final String mainImage;

  var screenSize;
  bool isDarkMode;

  HomePage({
    this.cityName,
    this.highTemp,
    this.lowTemp,
    this.temperature,
    this.weatherStatus,
    this.sunRise,
    this.sunSet,
    this.wind,
    @required this.scaffoldKey,
    this.isDarkMode,
    this.mainImage,
  });

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    this.context = context;
    //LocationService().getLocation();
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: _body(),
          );
        });
  }

  _body() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform(
          child: Center(
            child: SvgPicture.asset(
              isDarkMode ? "assets/images/dark/$mainImage" : "assets/images/light/$mainImage",
              width: screenSize.width,
            ),
          ),
          transform: Matrix4.translationValues(-170, 0, 0),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              /// City name section.
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(top: 5, left: 25),
                        child: GestureDetector(
                          child: Icon(
                            Icons.dehaze,
                            size: 30,
                            color: isDarkMode ? Colors.white70 : Colors.grey[600],
                          ),
                          onTap: () {
                            this.scaffoldKey.currentState.openDrawer();
                          },
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 5, right: 50),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Text(
                              cityName,
                              style: TextStyle(
                                fontSize: 30,
                                color: isDarkMode ? Colors.white70 : Colors.grey[600],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                this.context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Directionality(textDirection: TextDirection.rtl, child: SelectCity())),
                              );
                            },
                          ),
                          Padding(
                            child: SvgPicture.asset(
                              isDarkMode ? "assets/images/dark/mark_place.svg" : "assets/images/light/mark_place.svg",
                              width: 20,
                              color: isDarkMode ? Colors.white70 : Colors.grey[600],
                            ),
                            padding: const EdgeInsets.only(left: 8, bottom: 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// High and Low temperature
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(
                      isDarkMode ? "assets/images/dark/hot_temp.png" : "assets/images/light/hot_temp.png",
                      width: 20,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    ),
                    Text(
                      highTemp + "\u2103",
                      style: TextStyle(
                        fontFamily: "Vazir_FD",
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                    Text(" / "),
                    Image.asset(
                      isDarkMode ? "assets/images/dark/cold_temp.png" : "assets/images/light/cold_temp.png",
                      width: 20,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    ),
                    Text(
                      lowTemp + "\u2103",
                      style: TextStyle(
                        fontFamily: "Vazir_FD",
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              /// temperature section
              Container(
                margin: const EdgeInsets.only(right: 10, top: 0, bottom: 0),
                padding: const EdgeInsets.all(0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Positioned(
                      child: Text(
                        "c",
                        style: TextStyle(
                          inherit: false,
                          fontSize: 50,
                          color: isDarkMode ? Colors.white70 : Colors.grey[600],
                        ),
                      ),
                      top: 65,
                    ),
                    Positioned(
                      child: Text(
                        "\u02DA",
                        style: TextStyle(
                          inherit: false,
                          fontSize: 100,
                          color: isDarkMode ? Colors.white70 : Colors.grey[600],
                        ),
                      ),
                      top: 25,
                      right: -4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25, bottom: 0, top: 0),
                      child: Text(
                        temperature,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: "Vazir_FD",
                          fontSize: 110,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.grey[600],
                          inherit: false,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /// weather status
              Container(
                margin: const EdgeInsets.only(right: 22),
                child: Text(
                  weatherStatus,
                  style: TextStyle(
                    fontSize: 28,
                    color: isDarkMode ? Colors.white70 : Colors.grey[600],
                  ),
                ),
              ),

              /// sunrise section
              Container(
                margin: const EdgeInsets.only(right: 10, top: 18),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      isDarkMode ? "assets/images/dark/sunrise.svg" : "assets/images/light/sunrise.svg",
                      width: 40,
                      color: isDarkMode ? Colors.white70 : Colors.grey[700],
                    ),
                    Text(
                      sunRise,
                      style: TextStyle(
                        fontFamily: "Vazir_FD",
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              /// sunset section
              Container(
                margin: const EdgeInsets.only(right: 10, top: 18),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      isDarkMode ? "assets/images/dark/sunset.svg" : "assets/images/light/sunset.svg",
                      width: 40,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    ),
                    Text(
                      sunSet,
                      style: TextStyle(
                        fontFamily: "Vazir_FD",
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              /// wind section
              Container(
                margin: const EdgeInsets.only(right: 10, top: 18),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      isDarkMode ? "assets/images/dark/wind.svg" : "assets/images/light/wind.svg",
                      width: 40,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    ),
                    Text(
                      wind + "m/s",
                      style: TextStyle(
                        fontFamily: "Vazir_FD",
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              /// Chart section
              Container(
                margin: EdgeInsets.only(right: 45, top: 15),
                width: screenSize.width * 0.78,
                height: screenSize.height * 0.18,
                child: _chart(),
              )
            ],
          ),
        ),
      ],
    );
  }

  _chart() {

    List<FlSpot> spots = [];
    int counter = 0;
    print(HomePageInitialData.hoursTemp);
    HomePageInitialData.hoursTemp.forEach((item){
      spots.add(FlSpot(counter.ceilToDouble(), double.parse(item)));
      counter++;
    });

    return FlChart(
      chart: LineChart(
        LineChartData(
          backgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                  textStyle: TextStyle(fontFamily: "Vazir_FD", color: Colors.black),
                  showTitles: true,
                  getTitles: (val) {
                    switch (val.toInt()) {
                      case 0:
                        return HomePageInitialData.hours[0];
                      case 1:
                        return HomePageInitialData.hours[1];
                      case 2:
                        return HomePageInitialData.hours[2];
                      case 3:
                        return HomePageInitialData.hours[3];
                      case 4:
                        return HomePageInitialData.hours[4];
                      case 5:
                        return HomePageInitialData.hours[5];
                      case 6:
                        return HomePageInitialData.hours[6];
                      case 7:
                        return HomePageInitialData.hours[7];
                      case 8:
                        return HomePageInitialData.hours[8];
                      case 9:
                        return HomePageInitialData.hours[9];
                      case 10:
                        return HomePageInitialData.hours[10];
                      case 11:
                        return HomePageInitialData.hours[11];
                    }
                    return '';
                  }),
              leftTitles: SideTitles(showTitles: false)),
          lineTouchData: const LineTouchData(
            enabled: false,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              colors: isDarkMode ? [Colors.white70] : [Colors.grey[600]],
              isCurved: true,
              barWidth: 4,
              belowBarData: BelowBarData(
                show: false,
              ),
              dotData: FlDotData(show: true, dotColor: Colors.yellow[600], dotSize: 6),
            ),
          ],
        ),
      ),
    );
  }
}
