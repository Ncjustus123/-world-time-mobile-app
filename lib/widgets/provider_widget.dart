import 'package:flutter/material.dart';
import 'package:world_time/service/auth_service.dart';
import 'package:world_time/services/world_time.dart';

class Provider extends InheritedWidget {
  final AuthService auth;
  WorldTime instance;
  Provider({
    Key key,
    Widget child,
    this.auth,
  }) : super(key: key, child: child);

  setTime(WorldTime time) {
    this.instance = time;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(Provider) as Provider);
}
