import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_model.dart';

class PageIndicator extends StatelessWidget {
  _indicator(BuildContext context, bool isActive) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Theme.of(context).iconTheme.color : Colors.transparent,
        border: Border.all(color: Theme.of(context).iconTheme.color.withOpacity(0.5), width: 1)
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<CounterModel>(context).index;
    List<Widget> _buildIndicator() {
      List<Widget> indicators = List();
      for(int i = 0; i < 3; i++){
        indicators.add(i == currentIndex ? _indicator(context, true) : _indicator(context, false));
      }
      return indicators;
    }

    
    return Padding(
      padding: EdgeInsets.only(left: 18),
      child: Row(
        children: _buildIndicator(),
      ),
    );
  }
}