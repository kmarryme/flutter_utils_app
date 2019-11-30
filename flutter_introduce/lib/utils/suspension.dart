
import 'package:flutter/material.dart';

///浮窗
class Suspension extends StatefulWidget {
  @override
  _SuspensionState createState() => _SuspensionState();
}

class _SuspensionState extends State<Suspension> {
  Offset offset;

  ///漂浮按钮尺寸
  double kFloatWidgetSize = 70.0;

  ///拖动按钮时距离屏幕边缘的间距
  double kFloatWidgetPadding = 2.0;

  ///漂浮按钮的圆角尺寸
 double kFloatWidgetRadius = 20.0;

  @override
  void initState() {
    super.initState();
    offset = Offset(2, kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 50),
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          double originX = (offset.dx + details.delta.dx) < kFloatWidgetPadding ? kFloatWidgetPadding : (offset.dx + details.delta.dx);
          originX = originX > (MediaQuery.of(context).size.width - kFloatWidgetSize - kFloatWidgetPadding) ? (MediaQuery.of(context).size.width -
                  kFloatWidgetSize - kFloatWidgetPadding) : originX;
          double originY = (offset.dy + details.delta.dy) < 0 ? 0 : (offset.dy + details.delta.dy);
          originY = originY > (MediaQuery.of(context).size.height - kFloatWidgetSize - kToolbarHeight)
              ? (MediaQuery.of(context).size.height - kFloatWidgetSize - kToolbarHeight) : originY;
          setState(() {
            offset = Offset(originX, originY);
          });
        },
        onPanEnd: (details) {
          if (offset.dx < (MediaQuery.of(context).size.width / 2.0 - kFloatWidgetPadding)) {
            setState(() {
              offset = Offset(2, offset.dy);
            });
          } else {
            setState(() {
              offset = Offset(MediaQuery.of(context).size.width - kFloatWidgetSize - kFloatWidgetPadding, offset.dy);
            });
          }
        },
        child: Container(
          width: kFloatWidgetSize,
          height: kFloatWidgetSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(kFloatWidgetRadius)),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Center(
            child: ClipOval(
              child: Container(
                width: kFloatWidgetSize - 30,
                height: kFloatWidgetSize - 30,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}