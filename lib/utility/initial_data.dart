/// this data fetch from data base in splash screen

class HomePageInitialData {
  /// initial data section
  static bool isDarkMode = false;
  static String latt = "30.2924";
  static String longt = "57.0646";

  /// homePage data section
  static String mainImage = "big_sun.svg";
  static String cityName = "-----";
  static String highTemp = "----";
  static String lowTemp = "--";
  static String temperature = "--";
  static String sunRise = "-:--";
  static String sunSet = "-:--";
  static String wind = "--";
  static String weatherStatus = "----";

  static List<String> hours = ['1','2','3','4','5','6','7','8','9','10','11','12'];
  static List<String> hoursTemp = ['1','2','3','4','5','6','7','8','9','10','11','12'];

}

class DrawerInitialData{
  /// drawer data section
  static Map day1 = {
    "icon" : "rainy_icon.svg",
    "week_number" : 1,
    "high_temp" : 00,
    "low_temp" : 00,
  };

  static Map day2 = {
    "icon" : "rainy_icon.svg",
    "week_number" : 1,
    "high_temp" : 00,
    "low_temp" : 00,
  };

  static Map day3 = {
    "icon" : "rainy_icon.svg",
    "week_number" : 1,
    "high_temp" : 00,
    "low_temp" : 00,
  };

  static Map day4 = {
    "icon" : "rainy_icon.svg",
    "week_number" : 1,
    "high_temp" : 00,
    "low_temp" : 00,
  };

  static String lastUpdate = "-:--";
}