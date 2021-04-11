import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showCode(BuildContext context, String filePath) {
  rootBundle.loadString("lib/main/system/favorite.dart").then((val) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ShowCode(text: val);
      },
    );
  });
}

class ShowCode extends StatefulWidget {
  final String text;
  ShowCode({Key key, this.text}) : super(key: key);

  @override
  _ShowCodeState createState() => _ShowCodeState();
}

class _ShowCodeState extends State<ShowCode> {
  double fontSize = 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: ScreenUtil().setHeight(700),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          centerTitle: true,
          title: Text("本页源码"),
          // leading: IconButton(
          //   icon: Icon(Icons.content_copy),
          //   onPressed: (){
          //     Clipboard.setData(ClipboardData(text: widget.text));
          //   },
          // ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.clear),
          //     onPressed: () => Navigator.pop(context),
          //   ),
          // ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if(fontSize >= 10){
                    fontSize --;
                  }
                });
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  if(fontSize <= 18){
                    fontSize ++;
                  }
                });
              },
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
