/// this data fetch from data base in splash screen

class HomePageInitialData {
  /// initial data section
  static bool isDarkMode = false;

  /// homePage data section
  static String cityName = "Jiroft";
  static String highTemp = "40";
  static String lowTemp = "30";
  static String temperature = "38";
  static String sunRise = "5:40";
  static String sunSet = "7:20";
  static String wind = "20";
  static String weatherStatus = "suny";

}

class DrawerInitialData{
  /// drawer data section
  static Map day1 = {
    "icon" : "rainy_icon.svg",
    "week_number" : 0,
    "high_temp" : 35,
    "low_temp" : 15,
  };

  static Map day2 = {
    "icon" : "rainy_icon.svg",
    "week_number" : 1,
    "high_temp" : 35,
    "low_temp" : 15,
  };

  static Map day3 = {
    "icon" : "rainy_icon.svg",
    "week_number" : 2,
    "high_temp" : 35,
    "low_temp" : 15,
  };

  static Map day4 = {
    "icon" : "rainy_icon.svg",
    "week_number" : 3,
    "high_temp" : 35,
    "low_temp" : 15,
  };

  static Map lastUpdate = {
    "clock" : "8:20",
    "am_pm" : "pm"
  };
}