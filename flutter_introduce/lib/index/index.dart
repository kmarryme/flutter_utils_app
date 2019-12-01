import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_introduce/index/model.dart';
import 'package:flutter_introduce/utils/page_indicator.dart';
import 'package:flutter_introduce/utils/suspension.dart';

///首页
class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("images/bg1.jpg"),
      //     fit: BoxFit.fitHeight
      //   )
      // ),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: PageView(
                      children: <Widget>[
                        PageViewOne(),
                      ],
                      onPageChanged: (int index){
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
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
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
              Suspension()
            ],
          )
        ),
      ),
    );
  }
}

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
        childAspectRatio: 1.2
      ),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Hero(
                  tag: Data.allDataModel[index].name,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Data.allDataModel[index].widget,
                  ),
                ),
                onTap: (){
                  int type = Random().nextInt(4);
                  Navigator.push(context, CustomRoute(Data.allDataModel[index].page, 0));
                },
              ),
            ),
            Text("${Data.allDataModel[index].name}")
          ],
        );
      }
    );
  }
}

class CustomRoute extends PageRouteBuilder{
  final Widget widget;
  final int type;

  CustomRoute(this.widget, this.type)
  :super(
    // 设置过度时间
    transitionDuration:Duration(milliseconds: 500),
    // 构造器
    pageBuilder:(
      // 上下文和动画
      BuildContext context,
      Animation<double> animaton1,
      Animation<double> animaton2,
    ){
      return widget;
    },
    transitionsBuilder:(
      BuildContext context,
      Animation<double> animaton1,
      Animation<double> animaton2,
      Widget child,
    ){
      if(type == 0){
        return FadeTransition(
          opacity: Tween(begin: 0.0,end: 1.0)
          .animate(CurvedAnimation(
            parent: animaton1,
            curve: Curves.fastOutSlowIn,
          )),
          child: child,
        );
      }else if(type == 1){
        //缩放动画效果
        return ScaleTransition(
          scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
            parent: animaton1,
            curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }else if(type == 2){
        // 旋转加缩放动画效果
        return RotationTransition(
          turns: Tween(begin: 0.0,end: 1.0)
          .animate(CurvedAnimation(
            parent: animaton1,
            curve: Curves.fastOutSlowIn,
          )),
          child: ScaleTransition(
            scale: Tween(begin: 0.0,end: 1.0)
            .animate(CurvedAnimation(
              parent: animaton1,
              curve: Curves.fastOutSlowIn
            )),
            child: child,
          ),
        );
      }else{
        // 左右滑动动画效果
        return SlideTransition(
          position: Tween<Offset>(
            // 设置滑动的 X , Y 轴
            begin: Offset(-1.0, 0.0),
            end: Offset(0.0,0.0)
          ).animate(CurvedAnimation(
            parent: animaton1,
            curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }

    }
  );
}





