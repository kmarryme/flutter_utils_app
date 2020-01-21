import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduce/index/model.dart';

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
  List<Model> _searchList = List<Model>();
  List<Model> get searchList => _searchList;
  void changesSearchList(List<Model> list, bool type) {
    _isSearch = type;
    _searchList = list;
    notifyListeners();
  }

  

}


