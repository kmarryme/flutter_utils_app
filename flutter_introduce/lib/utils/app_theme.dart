import 'package:flutter/material.dart';

class AppTheme{

  ///白色主题
  static final ThemeData whiteVersionTheme = ThemeData(
    //用于类似墨水喷溅动画或指示菜单被选中的高亮颜色。
    highlightColor: Colors.transparent,
    //墨水喷溅的颜色。
    splashColor: Colors.transparent,
    //App主要部分的背景色（ToolBar,Tabbar等）。
    primaryColor: Colors.white,
    //primaryColor的较亮版本。
    primaryColorLight: Colors.white,
    //primaryColor的较暗版本。
    primaryColorDark: Colors.white,
    //作为Scaffold基础的Material默认颜色，典型Material应用或应用内页面的背景颜色。
    scaffoldBackgroundColor: Colors.white,
    //MaterialType.canvas Material的默认颜色。(画布)
    canvasColor: Colors.white,
    //Material中RaisedButtons使用的默认填充色。
    buttonColor: Color(0xffD86D2B),
    //Material被用作Card时的颜色。
    cardColor: Colors.white,
    //与primaryColor对比的颜色(例如 用作进度条的剩余部分)。 --用作大部分的背景颜色
    backgroundColor: Color(0xffF7F8F9),
    //Dialog元素的背景色。
    dialogBackgroundColor: Color(0xff302E3C),
    //IconThemeData类型，与卡片和画布颜色形成对比的图标主题。
    iconTheme: IconThemeData(
      color: Colors.black
    ),
    //TextTheme类型，与卡片和画布对比的文本颜色 ---字体颜色  
    textTheme: TextTheme(
      body1: TextStyle(
        color: Colors.black 
      ),
      body2: TextStyle(
        color: Colors.white 
      ),
    ),
    //InputDecorationTheme类型，InputDecorator、TextField和TextFormField的默认InputDecoration值基于此主题。
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.withOpacity(0.2),
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
      border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
      hintStyle: TextStyle(
        color: Color(0xff232323).withOpacity(0.5),
        fontSize: 16.0
      ),
    ),
    //ButtonThemeData类型，定义按钮小部件的默认配置，如RaisedButton和FlatButton。
    buttonTheme : ButtonThemeData(
      buttonColor: Color(0xffD86D2B),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),

    //IconThemeData类型，与原色(primary color)形成对比的图标主题。
    primaryIconTheme : IconThemeData(
      color: Colors.black
    ),

    //BottomAppBar的默认颜色。
    bottomAppBarColor: Color(0xff2A3139),

    //用于Widget无效的颜色，无论任何状态。例如禁用复选框。
    disabledColor: Color(0xffA9A9A9),

    //Dividers和PopupMenuDividers的颜色，也用于ListTiles中间，和DataTables的每行中间.
    dividerColor: Color(0xffB1BAC9).withOpacity(0.26),

    //用于输入验证错误的颜色，例如在TextField中。
    errorColor: Colors.red,

    //用于提示文本或占位符文本的颜色，例如在TextField中。
    hintColor: Colors.black,

    //TabBar中选项选中的指示器颜色。
    indicatorColor: Colors.blue,

    //选中行时的高亮颜色。
    selectedRowColor: Color(0xffA9A9A9),

    //文本字段中选中文本的颜色，例如TextField。
    textSelectionColor: Colors.blue,

    //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色。
    toggleableActiveColor: Color(0xffA9A9A9),

    //前景色（文本、按钮等）
    accentColor: Color(0xff2A3139),

    //使用的焦点颜色,表示组件具有输入焦点。
    focusColor: Colors.blue,

    //用于指示指针何时悬停在组件上的悬停颜色。
    hoverColor: Colors.blue,

    //有选定行时PaginatedDataTable标题的颜色。
    secondaryHeaderColor: Color(0xff151A26),

    //文本字段（如[textfield]）中光标的颜色。
    cursorColor: Colors.blue,

    //文本选择处理颜色
    textSelectionHandleColor: Colors.blue,

    //ButtonThemeData类型，定义按钮小部件的默认配置，如RaisedButton和FlatButton。
    //buttonTheme : 

    //String类型，字体类型
    //fontFamily: 

    //TextTheme类型，与卡片和画布对比的文本颜色
    //textTheme: 

    //TextTheme类型，与primary color形成对比的文本主题。
    //primaryTextTheme: 

    //TextTheme类型，与accent color形成对比的文本主题。
    //accentTextTheme: 

    //IconThemeData类型，与卡片和画布颜色形成对比的图标主题。
    //iconTheme: 

    //IconThemeData类型，与原色(primary color)形成对比的图标主题。
    //primaryIconTheme

    //IconThemeData类型,与前景色(accent color)形成对比的图标主题。
    //accentIconTheme: 

    //SliderThemeData类型，SliderThemeData类型，用于渲染Slider的颜色和形状。
    //sliderTheme: 

    //TabBarTheme类型, 一个主题，用于自定义选项卡栏指示器的尺寸、形状和颜色。
    //tabBarTheme: 

    //ChipThemeData类型,用于Chip的颜色和样式
    //chipTheme: 

    //TargetPlatform类型,widget应该适应目标的平台。
    //platform: 

    //MaterialTapTargetSize类型,配置特定材料部件的hit测试大小。
    //materialTapTargetSize: 

    //PageTransitionsTheme类型,每个目标平台的默认MaterialPageRoute转换。
    // pageTransitionsTheme: 

    //ColorScheme类型,一组13种颜色，可用于配置大多数组件的颜色属性。
    //colorScheme

    //Typography类型,用于配置TextTheme、primaryTextTheme和accentTextTheme的颜色和几何文本主题值。
    //typography: 

  );

  ///黑色主题
  static final ThemeData blackVersionTheme = ThemeData(
    //作为Scaffold基础的Material默认颜色，典型Material应用或应用内页面的背景颜色。
    scaffoldBackgroundColor: Color(0xff302E3C),
    //App主要部分的背景色（ToolBar,Tabbar等）。
    primaryColor: Color(0xff302E3C),
    //primaryColor的较暗版本。
    primaryColorDark: Color(0xff302E3C).withOpacity(0.16),
    //Material被用作Card时的颜色。
    cardColor: Color(0xff302E3C),
    //与primaryColor对比的颜色(例如 用作进度条的剩余部分)。 --用作大部分的背景颜色
    backgroundColor: Color(0xff232323),
    //Material中RaisedButtons使用的默认填充色。
    buttonColor: Color(0xffD86D2B),
    //MaterialType.canvas Material的默认颜色。(画布)
    canvasColor: Color(0xff302E3C),
    //primaryColor的较亮版本。
    primaryColorLight: Color(0xff302E3C),
    //IconThemeData类型，与卡片和画布颜色形成对比的图标主题。
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    //TextTheme类型，与卡片和画布对比的文本颜色 ---字体颜色  
    textTheme: TextTheme(
      body1: TextStyle(
        color: Colors.white 
      ),
      body2: TextStyle(
        color: Colors.black 
      ),
    ),
    //InputDecorationTheme类型，InputDecorator、TextField和TextFormField的默认InputDecoration值基于此主题。
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.withOpacity(0.2),
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
      border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 16.0
      ),
    ),
    //ButtonThemeData类型，定义按钮小部件的默认配置，如RaisedButton和FlatButton。
    buttonTheme : ButtonThemeData(
      buttonColor: Color(0xffD86D2B),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    //IconThemeData类型，与原色(primary color)形成对比的图标主题。
    primaryIconTheme : IconThemeData(
      color: Color(0xffEEA53C)
    ),   

    //Dialog元素的背景色。
    dialogBackgroundColor: Colors.white,

    //BottomAppBar的默认颜色。
    bottomAppBarColor: Color(0xff302E3C),

    //墨水喷溅的颜色。
    splashColor: Colors.transparent,

    //用于类似墨水喷溅动画或指示菜单被选中的高亮颜色。
    highlightColor: Colors.transparent,

    //用于Widget无效的颜色，无论任何状态。例如禁用复选框。
    disabledColor: Color(0xffA9A9A9),

    //Dividers和PopupMenuDividers的颜色，也用于ListTiles中间，和DataTables的每行中间.
    dividerColor: Color(0xffB1BAC9).withOpacity(0.26),

    //用于输入验证错误的颜色，例如在TextField中。
    errorColor: Colors.red,

    //用于提示文本或占位符文本的颜色，例如在TextField中。
    hintColor: Colors.white,

    //TabBar中选项选中的指示器颜色。
    indicatorColor: Colors.blue,

    //选中行时的高亮颜色。
    selectedRowColor: Color(0xffA9A9A9),

    //文本字段中选中文本的颜色，例如TextField。
    textSelectionColor: Colors.blue,

    //用于突出显示切换Widget（如Switch，Radio和Checkbox）的活动状态的颜色。
    toggleableActiveColor: Color(0xffA9A9A9),

    //前景色（文本、按钮等）
    accentColor: Color(0xff2A3139),

    //使用的焦点颜色,表示组件具有输入焦点。
    focusColor: Colors.blue,

    //用于指示指针何时悬停在组件上的悬停颜色。
    hoverColor: Colors.blue,

    //有选定行时PaginatedDataTable标题的颜色。
    secondaryHeaderColor: Color(0xff151A26),

    //文本字段（如[textfield]）中光标的颜色。
    cursorColor: Colors.blue,

    //文本选择处理颜色
    textSelectionHandleColor: Colors.blue,
    

    //ButtonThemeData类型，定义按钮小部件的默认配置，如RaisedButton和FlatButton。
    //buttonTheme : 

    //String类型，字体类型
    //fontFamily: 

    //TextTheme类型，与卡片和画布对比的文本颜色
    //textTheme: 

    //TextTheme类型，与primary color形成对比的文本主题。
    //primaryTextTheme: 

    //TextTheme类型，与accent color形成对比的文本主题。
    //accentTextTheme: 

    //IconThemeData类型，与卡片和画布颜色形成对比的图标主题。
    //iconTheme: 

    //IconThemeData类型,与前景色(accent color)形成对比的图标主题。
    //accentIconTheme: 

    //SliderThemeData类型，SliderThemeData类型，用于渲染Slider的颜色和形状。
    //sliderTheme: 

    //TabBarTheme类型, 一个主题，用于自定义选项卡栏指示器的尺寸、形状和颜色。
    //tabBarTheme: 

    //ChipThemeData类型,用于Chip的颜色和样式
    //chipTheme: 

    //TargetPlatform类型,widget应该适应目标的平台。
    //platform: 

    //MaterialTapTargetSize类型,配置特定材料部件的hit测试大小。
    //materialTapTargetSize: 

    //PageTransitionsTheme类型,每个目标平台的默认MaterialPageRoute转换。
    //pageTransitionsTheme: 

    //ColorScheme类型,一组13种颜色，可用于配置大多数组件的颜色属性。
    //colorScheme

    //Typography类型,用于配置TextTheme、primaryTextTheme和accentTextTheme的颜色和几何文本主题值。
    //typography: 
  );
  
}


