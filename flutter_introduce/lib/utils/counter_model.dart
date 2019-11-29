import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterModel with ChangeNotifier {

  int _index = 0;

  int get index => _index;

  set index(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }

  double _page = 0;

  double get page => _page;

  offsetNotifier(PageController pageController) {
    pageController.addListener(() {
      _page = pageController.page;
      notifyListeners();
    });
  }
  
  ///改变主题颜色true=>黑色 false=>白色 
  bool appTheme = true;
  ///四个主页面的下标
  int navigation = 0;
  

  ///改变主题颜色true=>黑色   false=>白色
  void changeTheme(bool themeStatus) {
    appTheme = themeStatus;
    notifyListeners();
  }

  ///改变四个主页面的下标 同时会改变页面
  void changeMainPage(int index) {
    navigation = index;
    notifyListeners();
  }
  

}


