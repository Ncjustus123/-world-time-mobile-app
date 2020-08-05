import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/first_veiw.dart';
import 'package:world_time/pages/sign_up_view.dart';
import 'package:world_time/service/auth_service.dart';
import 'package:world_time/widgets/provider_widget.dart';
import 'package:world_time/pages/profile_page.dart';

void main() => runApp(Provider(
      auth: AuthService(),
      child: FlutterEasyLoading(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => Loading(),
            '/firstveiw': (context) => FirstView(),
            '/signUp': (BuildContext context) =>
                SignUpview(authFormType: AuthFormType.SignUp),
            '/signIn': (BuildContext context) =>
                SignUpview(authFormType: AuthFormType.signIn),
            '/home': (context) => HomeController(),
            '/location': (context) => ChooseLocation(),
            '/profilepage': (context) => ProfilePage(),
          },
        ),
      ),
    ));

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            // return signedIn ? Home() : FirstView();
            return Home();
          }
          return CircularProgressIndicator();
        });
  }
}


