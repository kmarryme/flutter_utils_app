import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_introduce/routes.dart';
import 'package:flutter_introduce/utils/utils_function.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'main/caching_key/caching_key.dart';
import 'main/start/start.dart';
import 'utils/app_theme.dart';
import 'utils/counter_model.dart';
import 'utils/localizations.dart';

void main() {
  final counter = CounterModel();
  runApp(Provider<int>.value(
    value: 0,
    child: ChangeNotifierProvider.value(
      value: counter,
      child: MyApp(),
    ),
  ));

  ///强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((res) {
      Future(() {
        utilsGetData(CachingKey.app_theme_key, "bool").then((val) {
          if (val != null) {
            Provider.of<CounterModel>(context).changeTheme(val);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CounterModel counterModel = Provider.of<CounterModel>(context);
    return MaterialApp(
      title: 'Futures',
      debugShowCheckedModeBanner: false, //不显示右上角Debug字样
      onGenerateRoute: onGenerateRoute, //路由文件
      theme: counterModel.appTheme
          ? AppTheme.whiteVersionTheme
          : AppTheme.blackVersionTheme, //app主题
      localizationsDelegates: [
        //支持中文
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ChineseCupertinoLocalizations.delegate,
      ],
      locale: Locale("zh", "CH"),
      home: Start(),
    );
  }
}
