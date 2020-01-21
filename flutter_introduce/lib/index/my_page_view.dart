import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_introduce/utils/custom_route.dart';
import 'model.dart';

class MyPageView extends StatelessWidget {
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
        childAspectRatio: 1.2,
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

