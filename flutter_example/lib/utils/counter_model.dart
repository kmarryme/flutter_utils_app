import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/index/model.dart';
import 'package:flutter_example/main/caching_key/caching_key.dart';
import 'package:flutter_example/utils/utils_function.dart';

class CounterModel with ChangeNotifier {

  Future<void> initState()async { 
    bool res = await utilsGetData(CachingKey.app_theme_key, "bool");
    if (res != null) {
      _appTheme = res;
    }

  }

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
  bool _appTheme = true;
  bool get appTheme => _appTheme;

  ///改变主题颜色true=>黑色   false=>白色
  void changeTheme(bool theme) {
    _appTheme = theme;
    notifyListeners();
  }

  ///搜索
  bool _isSearch = false;
  bool get isSearch => _isSearch;
  List<Model> _searchList = [];
  List<Model> get searchList => _searchList;
  void changesSearchList(List<Model> list, bool type) {
    _isSearch = type;
    _searchList = list;
    notifyListeners();
  }

  ///密码方式
  int _unlockMethod = 0;
  int get unlockMethod => _unlockMethod;
  void changesUnlockMethod(int type) {
    _unlockMethod = type;
    notifyListeners();
  }
}


