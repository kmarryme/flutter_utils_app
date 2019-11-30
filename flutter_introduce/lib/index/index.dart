import 'package:flutter/material.dart';
import 'package:flutter_introduce/index/model.dart';
import 'package:flutter_introduce/utils/page_indicator.dart';

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
        // bottomNavigationBar: BottomNavigationBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   unselectedIconTheme: Theme.of(context).iconTheme,
        //   selectedIconTheme: Theme.of(context).iconTheme,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.settings),
        //       title: Text("")
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.settings),
        //       title: Text("")
        //     )
        //   ],
        // ),
        body: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: MediaQuery.of(context).padding.bottom),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 90,
                child: PageView(
                  children: <Widget>[
                    PageViewOne(),
                    PageViewOne()
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
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Data.allDataModel[index].widget,
                ),
                onTap: (){
                  Navigator.push(context, ScaleRoute(page: Data.allDataModel[index].page));
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


class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
    : super(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) => page,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) => ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        child: child,
      ),
    );
}







