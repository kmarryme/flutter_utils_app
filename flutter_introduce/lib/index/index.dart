import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduce/main/caching_key/caching_key.dart';
import 'package:flutter_introduce/utils/page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/counter_model.dart';
import '../utils/utils_function.dart';
import 'my_page_view.dart';
import 'my_page_view_favorite.dart';

///首页
class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  PageController controller;
  int pageIndex = 1;

  @override
  void initState() {
    controller = PageController(initialPage: pageIndex);
    utilsGetData(CachingKey.start_key, 'int').then((val) {
      if (val != null) {
        controller.jumpToPage(val);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 414, height: 812, allowFontScaling: true)
          ..init(context); //屏幕适配 414*812
    return GestureDetector(
      child: FabCircularMenu(
        ringColor: Colors.blue.withOpacity(0.5),
        ringWidth: 120,
        fabColor: Colors.blue,
        animationDuration: Duration(milliseconds: 500),
        options: getItemList(),
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("images/bg1.jpg"),
          //     fit: BoxFit.fitHeight
          //   )
          // ),
          child: Scaffold(
            // backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: PageView(
                      controller: controller,
                      children: <Widget>[
                        MyPageViewFavorite(),
                        MyPageView(),
                      ],
                      onPageChanged: (int index) {
                        FocusScope.of(context).requestFocus(FocusNode());
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
                        pageCount: 2,
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
      ),
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
    );
  }

  List<Widget> getItemList() {
    return <Widget>[
      getItem("收藏", Icons.favorite, "/favorite"),
      getItem("分享", Icons.share, ""),
      getItem("设置", Icons.settings, "/setting"),
      getItem("反馈", Icons.email, ""),
      getItem("关于", Icons.help, "/about"),
    ];
  }

  InkWell getItem(String name, IconData icon, String path) {
    return InkWell(
      child: Container(
        width: 110,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(name), Icon(icon)],
        ),
      ),
      onTap: () {
        if (name == "分享") {
          ShareExtend.share("分享", "text");
        } else if(name == "反馈"){
          launch("mailto:swangke@163.com");
        }else{
          Navigator.pushNamed(context, path);
        }
      },
    );
  }
}

