import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String date;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      //String timeString = '2020-08-05T12:08:49.568126+02:00';
      DateTime parsedTime = DateTime.parse(datetime);
      date = DateFormat.yMMMMEEEEd("en_US").format(parsedTime);
      time = DateFormat.jm("en_US").format(parsedTime);
      print(date);
       print(time); //substring(1, 3);
          print(datetime);
      //     print(offset);

      // DateTime now = DateTime.parse(datetime);
      // now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = parsedTime.hour > 6 && parsedTime.hour < 18 ? true : false;

      // time = DateFormat.jm().format(par);
      return data;
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
    ;
  }
}
