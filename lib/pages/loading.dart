import 'package:flutter/material.dart';
import 'package:world_time/pages/first_veiw.dart';
import 'package:world_time/pages/profile_page.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/widgets/provider_widget.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime();
    Provider.of(context).setTime(instance);
    Future.delayed(Duration(milliseconds: 5000));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FirstView()));
    //FirstView
    // Navigator.pushReplacementNamed(context, '/home', arguments: {
    //   'location': instance.location,
    //   'flag': instance.flag,
    //   'time': instance.time,
    //   'isDaytime': instance.isDaytime,
    // });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SpinKitWave(
            color: Colors.white,
            size: 80.0,
          ),
        ),
      ),
    );
  }
}
