import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:world_time/service/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:world_time/service/network_call.dart';
import 'package:world_time/widgets/provider_widget.dart';

final primaryColor = const Color(0xFF75A2EA);

enum AuthFormType { signIn, SignUp }

class SignUpview extends StatefulWidget {
  final AuthFormType authFormType;
  SignUpview({Key key, @required this.authFormType}) : super(key: key);
  @override
  _SignUpviewState createState() =>
      _SignUpviewState(authFormType: this.authFormType);
}

class _SignUpviewState extends State<SignUpview> {
  AuthFormType authFormType;
  _SignUpviewState({this.authFormType});
  final formKey = GlobalKey<FormState>();
  String _email, _password, _name;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == 'signUp') {
      setState(() {
        authFormType = AuthFormType.SignUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  void submit() async {
    final form = formKey.currentState;
    form.save();
    try {
      EasyLoading.show(status: 'loading...');

      // final auth = Provider.of(context).auth;
      // if (authFormType == AuthFormType.signIn) {
      //   String uid = await auth.signInWithEmailAndPassword(_email, _password);
      //   print('Signed In with ID $uid');
      //   EasyLoading.dismiss(animation: true);
      //   Navigator.of(context).pushReplacementNamed('/home');
      // } else {
      //   String uid =
      //       await auth.createUserWithEmailAndPassword(_email, _password, _name);
      //   print('Signed Up with  New ID $uid');
      //   EasyLoading.dismiss(animation: true);
      //   Navigator.of(context).pushReplacementNamed('/home'); 
      // }

      if (authFormType == AuthFormType.signIn) {
        if (await login(_email, _password)) {
          Navigator.of(context).pushReplacementNamed('/home');
          print("login okay!");
        } else {
          print("login failed!");
        }
        EasyLoading.dismiss(animation: true);
      }
    } catch (e) {
      EasyLoading.dismiss(animation: true);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bgimage.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.srcOver)),
          ),
          // color: primaryColor,
          height: _height,
          width: _width,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.05),
                buildHeaderText(),
                SizedBox(height: _height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: buildInputs() + buildButtons(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.SignUp) {
      _headerText = 'Create New Account';
    } else {
      _headerText = 'Sign in';
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    //if were in the sign up state add name

    if (authFormType == AuthFormType.SignUp) {
      textFields.add(
        TextFormField(
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration('Name'),
          onSaved: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(
        height: 20,
      ));
    }

    // add email & password
    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration('Email'),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(
      height: 20,
    ));

    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration('Password'),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(
      height: 20,
    ));
    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = 'Create New Account';
      _newFormState = 'signUp';
      _submitButtonText = 'Sign In';
    } else {
      _switchButtonText = 'Have an Account? Sign In';
      _newFormState = 'Sign In';
      _submitButtonText = 'Sign In';
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: submit,
        ),
      ),
      FlatButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }

  Future<bool> login(String username, String password) async {
    AuthenticationClient auth = AuthenticationClient.create();
    Map<String, dynamic> loginData = {
      "username": username,
      "password": password
    };
    try {
      Response r = await auth.login(loginData);
      if (r.isSuccessful) {
        print(r.bodyString);

        Map formattedRes = json.decode(r.bodyString);

        print("Token is ======> ${formattedRes['object']['token']}");

        getProfile(formattedRes['object']['token']);
        return true;
      } else {
        print(r.bodyString);
        return false;
      }
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<bool> getProfile(String token) async {
    AuthenticationClient auth = AuthenticationClient.create(token: token);
    Response ProfileResponse = await auth.getProfile();
    print(ProfileResponse.bodyString);
  }

  Future<bool> updateProfile(String nextOfKin, String nextOfKinPhone , String firstName,String lastName, String email , String phoneNumber, 
   String gender, String referralCode, String address, String middleName, String dateJoined, String dateOfBirth, String title, String referrer, String userType) async {
    AuthenticationClient auth = AuthenticationClient.create();
    Map<String, dynamic> updateProfileData = {
       "nextOfKin": nextOfKin,
      "nextOfKinPhone": nextOfKinPhone,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "gender": gender,
      "referralCode": referralCode,
      "address": address,
      "middleName": middleName,
      "dateJoined": dateJoined,
      "dateOfBirth":dateOfBirth,
      "title": title,
      "referrer": referrer,
      "userType": userType

    };
    Response ProfileResponse = await auth.updateProfile(updateProfileData);
    print(ProfileResponse.bodyString);
  }
}
