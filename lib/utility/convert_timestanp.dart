class ConvertTimestamp{

  static DateTime convert(int timestamp){
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toUtc();
  }
}