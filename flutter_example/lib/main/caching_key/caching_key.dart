class CachingKey{
  ///app主题key
  static const String app_theme_key = "app_theme_key";
  ///收藏widget key
  static const String favorite_key = "favorite_key";
  ///启动时 默认显示页面的下标 key
  static const String start_key = "start_key";
  ///是否显示启动页面 key
  static const String guide_key = "guide_key";
  ///null || false -- 未开启   true --- 开启
  static const String open_unlock = "open_unlock";
  ///null || 0--无 1--图案  2--数字密码  3--指纹
  static const String unlock_method = "unlock_method";
  ///图案密码数组 key
  static const String pattern_list = "pattern_list";
  ///数字密码key
  static const String number_password = "number_password";
}