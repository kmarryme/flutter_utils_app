import 'dart:math';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduce/index/model.dart';
import 'package:flutter_introduce/main/caching_key/caching_key.dart';
import 'package:flutter_introduce/utils/page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../utils/counter_model.dart';
import '../utils/utils_function.dart';

///首页
class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int pageIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((res)  {
      Future((){
        utilsGetData(CachingKey.app_theme_key, "bool").then((val) {
          Provider.of<CounterModel>(context).changeTheme(val);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 414, height: 812, allowFontScaling: true)
          ..init(context); //屏幕适配 414*812
    return FabCircularMenu(
      ringColor: Colors.blue.withOpacity(0.5),
      ringWidth: 120,
      fabColor: Colors.blue,
      animationDuration: Duration(milliseconds: 500),
      options: getItem(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.jpg"),
            fit: BoxFit.fitHeight
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 90,
                  child: PageView(
                    children: <Widget>[
                      PageViewOne(),
                    ],
                    onPageChanged: (int index) {
                      setState(() {
                        pageIndex = index;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    height: 50,
                    child: MyPageIndicator(
                      currentIndex: pageIndex,
                      pageCount: 1,
                      unselectedColor: Colors.grey.withOpacity(0.3),
                      selectedColor: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getItem() {
    return <Widget>[
      Container(
        width: 110,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("收藏"), Icon(Icons.favorite)],
        ),
      ),
      Container(
        width: 110,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("分享"), Icon(Icons.share)],
        ),
      ),
      Container(
        width: 110,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("设置"), Icon(Icons.settings)],
        ),
      ),
      Container(
        width: 110,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("反馈"), Icon(Icons.email)],
        ),
      ),
      Container(
        width: 110,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("关于"), Icon(Icons.help)],
        ),
      ),
    ];
  }
}

// bool appThemeFlag = false;

// @override
// void initState() {
//   utilsGetData(CachingKey.app_theme_key, 'bool').then((val) {
//     setState(() {
//       appThemeFlag = !val;
//     });
//   });
//   super.initState();
// }

// Container(
//             margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Text(
//                   Provider.of<CounterModel>(context).appTheme ? '黑色主题' : '白色主题',
//                   style: TextStyle(
//                     color: Theme.of(context).textTheme.body1.color,
//                     fontSize: ScreenUtil().setSp(16),
//                   ),
//                 ),
//                 Switch(
//                   value: appThemeFlag,
//                   onChanged: (val) {
//                     appThemeFlag = val;
//                     Provider.of<CounterModel>(context).changeTheme(!val);
//                     utilsetData(CachingKey.app_theme_key, !val);
//                   },
//                 ),
//               ],
//             ),
//           ),

class PageViewOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(5),
      physics: NeverScrollableScrollPhysics(),
      itemCount: Data.allDataModel.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 4,
          //纵轴间距
          mainAxisSpacing: 30.0,
          //横轴间距
          crossAxisSpacing: 0.0,
          //子组件宽高长度比例
          childAspectRatio: 1.2),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Data.allDataModel[index].widget,
                ),
                onTap: () {
                  int type = Random().nextInt(4);
                  Navigator.push(
                    context,
                    CustomRoute(Data.allDataModel[index].page, type),
                  );
                },
              ),
            ),
            Text(
              "${Data.allDataModel[index].name}",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        );
      },
    );
  }
}

class CustomRoute extends PageRouteBuilder {
  final Widget widget;
  final int type;

  CustomRoute(this.widget, this.type)
      : super(
            // 设置过度时间
            transitionDuration: Duration(milliseconds: 500),
            // 构造器
            pageBuilder: (
              // 上下文和动画
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
            ) {
              return widget;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
              Widget child,
            ) {
              if (type == 0) {
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animaton1,
                    curve: Curves.fastOutSlowIn,
                  )),
                  child: child,
                );
              } else if (type == 1) {
                //缩放动画效果
                return ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animaton1, curve: Curves.fastOutSlowIn)),
                  child: child,
                );
              } else if (type == 2) {
                // 旋转加���放动画效果
                return RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animaton1,
                    curve: Curves.fastOutSlowIn,
                  )),
                  child: ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animaton1, curve: Curves.fastOutSlowIn)),
                    child: child,
                  ),
                );
              } else {
                // 左右滑动动画效果
                return SlideTransition(
                  position: Tween<Offset>(
                          // 设置滑动的 X , Y 轴
                          begin: Offset(-1.0, 0.0),
                          end: Offset(0.0, 0.0))
                      .animate(CurvedAnimation(
                          parent: animaton1, curve: Curves.fastOutSlowIn)),
                  child: child,
                );
              }
            });
}
