import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hava_negar/services/location_service.dart';


class HomePage extends StatefulWidget {
  String cityName, highTemp, lowTemp, temperature, weatherStatus;
  String sunRise, sunSet, wind;

  HomePage({
    this.cityName = "Kerman",
    this.highTemp = "40",
    this.lowTemp = "30",
    this.temperature = "38",
    this.weatherStatus = "Sunny",
    this.sunRise = "5.40",
    this.sunSet = "7.20",
    this.wind = "20",
  });

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var screenSize;
  bool isDarkMode = false;

  _body() {
    return Stack(
      children: <Widget>[
        Transform(
          child: Center(
            child: SvgPicture.asset(
              "assets/images/light/light_sun.svg",
              width: screenSize.width,
            ),
          ),
          transform: Matrix4.translationValues(-170, 0, 0),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// City name section.
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 40, right: 50),
                      child: Row(
                        children: <Widget>[
                          Text(
                            widget.cityName,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Padding(
                            child: SvgPicture.asset(
                              isDarkMode ? "assets/images/dark/mark_place.svg" : "assets/images/light/mark_place.svg",
                              width: 20,
                            ),
                            padding: const EdgeInsets.only(right: 8, bottom: 4),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40, left: 25),
                      child: Icon(
                        Icons.dehaze,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),

              /// High and Low temperature
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Row(
                  children: <Widget>[
                    Text("\u2103" + widget.highTemp),
                    Image.asset(
                      isDarkMode ? "assets/images/dark/hot_temp.png" : "assets/images/light/hot_temp.png",
                      width: 20,
                    ),
                    Text(" / "),
                    Text("\u2103" + widget.lowTemp),
                    Image.asset(
                      isDarkMode ? "assets/images/dark/cold_temp.png" : "assets/images/light/cold_temp.png",
                      width: 20,
                    ),
                  ],
                ),
              ),

              /// temperature section
              Container(
                margin: const EdgeInsets.only(right: 10, top: 0, bottom: 0),
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(
                        "c",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.grey[600],
                        ),
                      ),
                      top: 45,
                    ),
                    Positioned(
                      child: Text(
                        "\u02DA",
                        style: TextStyle(
                          fontSize: 100,
                          color: Colors.grey[600],
                        ),
                      ),
                      top: 2,
                      right: -4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25, bottom: 0, top: 0),
                      child: Text(
                        widget.temperature,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 110,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
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
                  widget.weatherStatus,
                  style: TextStyle(fontSize: 28, color: Colors.grey[600]),
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
                      color: Colors.grey[700],
                    ),
                    Text(
                      widget.sunRise+"am",
                      style: TextStyle(color: Colors.grey[600]),
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
                      color: Colors.grey[700],
                    ),
                    Text(
                      widget.sunSet+"pm",
                      style: TextStyle(color: Colors.grey[600]),
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
                      color: Colors.grey[700],
                    ),
                    Text(
                      widget.wind+"m/s",
                      style: TextStyle(color: Colors.grey[600]),
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screenSize = MediaQuery.of(context).size;
    LocationService().getLocation();
    print(screenSize.height);

    return Scaffold(
      body: _body(),
    );
  }

  _chart() {
    return FlChart(
      chart: LineChart(
        LineChartData(
          backgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
                getTitles: (val) {
                  switch (val.toInt()) {
                    case 0:
                      return '00:00';
                    case 1:
                      return '04:00';
                    case 2:
                      return '08:00';
                    case 3:
                      return '12:00';
                    case 4:
                      return '16:00';
                    case 5:
                      return '20:00';
                    case 6:
                      return '23:59';
                    case 7:
                      return '12';
                  }
                  return '';
                }
            ),
            leftTitles: SideTitles(showTitles: false)
          ),
          lineTouchData: const LineTouchData(
              enabled: false,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 2),
                FlSpot(2, 1.5),
                FlSpot(3, 3),
                FlSpot(4, 3.5),
                FlSpot(5, 5),
                FlSpot(6, 8),
                FlSpot(7, 5),
              ],
              colors: [Colors.grey[600]],
              isCurved: true,
              barWidth: 4,
              belowBarData: BelowBarData(
                show: false,
              ),
              dotData: FlDotData(
                  show: true,
                dotColor: Colors.yellow[600],
                dotSize: 6
              ),
            ),
          ],
        ),
      ),
    );
  }
}
