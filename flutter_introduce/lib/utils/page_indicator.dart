import 'package:flutter/material.dart';

///分页指示器
class MyPageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  final Color unselectedColor;
  final Color selectedColor;
  const MyPageIndicator(
      {Key key,
      this.currentIndex,
      this.pageCount,
      this.unselectedColor,
      this.selectedColor})
      : super(key: key);

  indicator(bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        height: 7,
        width: 7,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? selectedColor : unselectedColor,
        ),
      ),
    );
  }

  buildPageIndicatoes() {
    List<Widget> indicatorList = [];
    for (int i = 0; i < pageCount; i++) {
      indicatorList.add(i == currentIndex ? indicator(true) : indicator(false));
    }
    return indicatorList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildPageIndicatoes(),
    );
  }
}
