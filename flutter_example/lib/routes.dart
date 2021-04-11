import 'package:flutter/material.dart';
import 'main/system/about.dart';
import 'main/system/favorite.dart';
import 'main/system/number_pwd.dart';
import 'main/system/pattern.dart';
import 'main/system/setting.dart';
import 'main/system/unlock_method.dart';

final routes = {
  "/favorite": (context) => Favorite(), 
  "/setting": (context) => Setting(), 
  "/unlock_method": (context) => UnlockMethod(), 
  "/pattern_unlock": (context) =>  PatternUnlock(),
  "/number_pwd": (context) =>  NumberPwd(),
  "/about": (context) =>  About(),
};


//固定写法 判断路由是否带参
var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

