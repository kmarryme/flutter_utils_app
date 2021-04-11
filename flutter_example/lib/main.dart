import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/routes.dart';
import 'package:flutter_example/utils/utils_function.dart';
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
  final CounterModel counterModel = CounterModel();

  @override
  void initState() {
    super.initState();
    counterModel.initState().then((_) {
      if(mounted)setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => counterModel),
      ],
      builder: (context, child){
        return MaterialApp(
          title: 'Flutter example',
          debugShowCheckedModeBanner: false, //不显示右上角Debug字样
          onGenerateRoute: onGenerateRoute, //路由文件
          theme: context.watch<CounterModel>().appTheme
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
      },
    );
    
  }
}
