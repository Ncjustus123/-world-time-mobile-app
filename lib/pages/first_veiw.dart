import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:world_time/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFF75A2EA);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bgimage.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.srcOver)),
        ),
        width: _width,
        height: _height,
        // color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: _height * 0.10,
              ),
              Text('Welcome',
                  style: TextStyle(fontSize: 44, color: Colors.white)),
              SizedBox(
                height: _height * 0.10,
              ),
              AutoSizeText('Lets show you what time it is around the world',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: Colors.white)),
              SizedBox(
                height: _height * 0.10,
              ),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 35.0, right: 40.0),
                  child: Text('Get Started',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                          title: 'Would you like to create a free account',
                          description:
                              "With your account, your data will secured safely ",
                          primaryButtonRoute: '/signUp',
                          primaryButtonText: 'create my account',
                          secondaryButtonRoute: '/home',
                          secondaryButtonText: 'Maybe later'));
                },
              ),
              SizedBox(height: _height * 0.05),
              FlatButton(
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('sign In');
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
