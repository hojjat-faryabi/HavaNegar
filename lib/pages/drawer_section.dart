import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hava_negar/utility/farsi_names.dart';

class DrawerSection extends StatelessWidget {
  final Map day1, day2, day3, day4;
  final String lastUpdate;

  final bool isDarkMode;
  final onSwitchClicked;

  DrawerSection(
      {this.day1,
      this.day2,
      this.day3,
      this.day4,
      this.lastUpdate,
      @required this.isDarkMode,
      @required this.onSwitchClicked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Drawer(
        child: Container(
          color: isDarkMode
              ? Colors.grey[800]
              : Colors.white70,
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              day1["low_temp"].toString() + "\u2103/" + day1["high_temp"].toString() + "\u2103",
                              style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                            ),
                            SvgPicture.asset(
                              isDarkMode ? "assets/images/dark/${day1["icon"]}" : "assets/images/light/${day1["icon"]}",
                              width: 32,
                            ),
                            Text(
                              FarsiNames.weekNumbers[day1["week_number"]],
                              style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              day2["low_temp"].toString() + "\u2103/" + day2["high_temp"].toString() + "\u2103",
                              style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                            ),
                            SvgPicture.asset(
                              isDarkMode ? "assets/images/dark/${day2["icon"]}" : "assets/images/light/${day2["icon"]}",
                              width: 32,
                            ),
                            Text(
                              FarsiNames.weekNumbers[day2["week_number"]],
                              style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              day3["low_temp"].toString() + "\u2103/" + day3["high_temp"].toString() + "\u2103",
                              style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                            ),
                            SvgPicture.asset(
                              isDarkMode ? "assets/images/dark/${day3["icon"]}" : "assets/images/light/${day3["icon"]}",
                              width: 32,
                            ),
                            Text(
                              FarsiNames.weekNumbers[day3["week_number"]],
                              style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              day4["low_temp"].toString() + "\u2103/" + day4["high_temp"].toString() + "\u2103",
                              style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                            ),
                            SvgPicture.asset(
                              isDarkMode ? "assets/images/dark/${day4["icon"]}" : "assets/images/light/${day4["icon"]}",
                              width: 32,
                            ),
                            Text(
                              FarsiNames.weekNumbers[day4["week_number"]],
                              style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          "آخرین بروز رسانی" + this.lastUpdate,
                          style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Switch(
                        value: this.isDarkMode,
                        onChanged: this.onSwitchClicked,
                        activeColor: Colors.grey[600],
                        activeTrackColor: Colors.yellow,
                      ),
                      Text(
                        "حالت تیره",
                        style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        elevation: 20,
      ),
    );
  }
}
