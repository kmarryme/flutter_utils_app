import 'package:flutter/material.dart';

///跳转动画
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
          },
        );
}
