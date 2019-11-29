/*
 * utils
 * Created by wang_ke
 */
import 'package:shared_preferences/shared_preferences.dart';


///判空
bool isEmpty(String str) {
  if (str == null || str == '') {
    return true;
  }
  return false;
}

///持久化缓存 储存
Future<bool> utilsetData(String key, dynamic value) async {
  if (isEmpty(key)) {
    return false;
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (value is String) {
    return prefs.setString(key, value);
  } else if (value is bool) {
    return prefs.setBool(key, value);
  } else if (value is int) {
    return prefs.setInt(key, value);
  } else if (value is double) {
    return prefs.setDouble(key, value);
  } else if (value is List) {
    return prefs.setStringList(key, value);
  }
  return false;
}

///持久化缓存 删除
void utilsDeleteData(List<String> keys) async {
  if (keys == null || keys.length == 0) {
    return;
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  keys.forEach((item) {
    prefs.remove(item);
  });
}

///持久化缓存 获取
Future<dynamic> utilsGetData(String key, String type) async {
  if (isEmpty(key)) {
    return null;
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (type == "list") {
    return prefs.getStringList(key);
  } else if (type == "int") {
    return prefs.getInt(key);
  } else if (type == "bool") {
    return prefs.getBool(key);
  } else if (type == "double") {
    return prefs.getDouble(key);
  } else if (type == "string") {
    return prefs.getString(key);
  }
  return prefs.get(key);
}


