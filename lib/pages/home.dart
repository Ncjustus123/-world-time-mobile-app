import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:world_time/pages/profile_page.dart';
import 'package:world_time/service/auth_service.dart';
import 'package:world_time/service/network_call.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/widgets/provider_widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    // data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    var instance = Provider.of(context).instance;
    data = {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
      'date': instance.date,
    };

    print(data);

    String bgImage = (data['isDaytime'] ?? true) ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    printtime();

    return WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('Chinedu'),
                  accountEmail: Text('chinedu@chinedu.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.android
                            ? Colors.white
                            : Colors.white,
                    child: Text(
                      'C',
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(' View Profile'),
                  trailing: Icon(Icons.cloud),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            leading: FlatButton(
              child: Icon(Icons.menu),
              onPressed: () => toggleDrawer(),
            ),
            automaticallyImplyLeading: false,
            title: Center(child: Text('World Time App')),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: () async {
                  try {
                    AuthService auth = Provider.of(context).auth;
                    await auth.signOut();
                    print('Signed out');
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
          backgroundColor: bgColor,
          body: Builder(builder: (context) {
            parentContext = context;
            return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/$bgImage'),
                  fit: BoxFit.cover,
                )),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
                  child: StatefulBuilder(builder: (context, newState) {
                    return Column(
                      children: <Widget>[
                        FlatButton.icon(
                          onPressed: () async {
                            dynamic result =
                                await Navigator.pushNamed(context, '/location');
                            if (result != null)
                              newState(() {
                                data = {
                                  'time': result['time'],
                                  'location': result['location'],
                                  'flag': result['flag'],
                                  'isDaytime': result['isDaytime'],
                                  'date': result['date'],
                                };
                              });
                          },
                          icon: Icon(
                            Icons.edit_location,
                            color: Colors.grey[300],
                          ),
                          label: Text(
                            'Edit Location',
                            style: TextStyle(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              data['location'],
                              style: TextStyle(
                                fontSize: 28.0,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          time ?? data['time'],
                          style: TextStyle(
                            fontSize: 66.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          data['date'],
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.white,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            );
          })),
    );
  }

  final dateTime = DateTime.now();
  void printtime() {
    print(
        DateTimeFormat.format(dateTime, format: AmericanDateFormats.dayOfWeek));
  }

  void toggleDrawer() {
    if (Scaffold.of(parentContext).isDrawerOpen) {
      Scaffold.of(parentContext).openEndDrawer();
    } else {
      Scaffold.of(parentContext).openDrawer();
    }
    // fetchData();
  }

  void fetchAlbum() async {
    http.Response response = await http.post(
      'https://client.libmot.com/api/token',
      body: jsonEncode(
          {"username": "otuemeemmanuel@gmail.com", "password": "onyedikachi"}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // print(response.body);

    Map formattedRes = json.decode(response.body);

    print("Token is ======> ${formattedRes['object']['token']}");

    getProfile(formattedRes['object']['token']);
  }

  String time;
  void getProfile(String token) async {
    http.Response response = await http.get(
      'https://client.libmot.com/api/Account/GetProfile',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'bearer $token',
      },
    );

    print(response.body);
    Map formattedRes = json.decode(response.body);

    print("Token is ======> ${formattedRes['object']['token']}");
    setState(() {
      time = formattedRes['object']['token'];
    });
  }
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

}
