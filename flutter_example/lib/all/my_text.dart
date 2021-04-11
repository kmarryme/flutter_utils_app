import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/show_text.dart';

///文本
class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Text"),
      ),
      body: SingleChildScrollView(
        child: TextBody(),
      ),
    );
  }
}

class TextBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Text('默认文本显示'),
        ShowText(
          text: '''
Text(
    '文本大小设置',
    style: TextStyle(
        fontSize: 20,
    ),
),''',
        ),
        Text(
          '文本大小设置',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本大小设置',
    style: TextStyle(
        fontSize: 20,
    ),
),''',
        ),
        Text(
          '这一行文本是：当字数太多，屏幕宽度着不下的时候在文本最后显示省略号,最多显示两行。 这一行文本是：当字数太多，屏幕宽度着不下的时候在文本最后显示省略号,最多显示两行。 ',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        ShowText(
          text: '''
Text(
    '这一行文本是：当字数太多....',
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
),''',
        ),
        Text(
          '文本添加背景颜色',
          style: TextStyle(
            backgroundColor: Color.fromARGB(88, 255, 0, 0),
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本添加背景颜色',
    style: TextStyle(
        backgroundColor: Color.fromARGB(
          88, 255, 0, 0,
        ),
    ),
),''',
        ),
        Text(
          '文本添加颜色',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(100, 0, 0, 128),
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本添加颜色',
    style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(100, 0, 0, 128),
    ),
),''',
        ),
        Text(
          '文本添加下划线',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本添加下划线',
    style: TextStyle(
        decoration: TextDecoration.underline,
    ),
),''',
        ),
        Text(
          '文本添加上划线',
          style: TextStyle(
            decoration: TextDecoration.overline,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本添加上划线',
    style: TextStyle(
        decoration: TextDecoration.overline,
    ),
),''',
        ),
        Text(
          '文本添加删除/中划线',
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        ShowText(
          text: '''
Text(
    '文本添加删除/中划线',
    style: TextStyle(
        decoration: TextDecoration.lineThrough
    ),
),''',
        ),
        Text(
          '文本划线颜色',
          style: TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: Color(0xffff0000),
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本划线颜色',
    style: TextStyle(
        decoration: TextDecoration.underline,
        decorationColor: Color(0xffff0000),
    ),
),''',
        ),
        Text(
          '文本两条下划线',
          style: TextStyle(
            decorationStyle: TextDecorationStyle.double,
            decoration: TextDecoration.underline,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本两条下划线',
    style: TextStyle(
        decorationStyle: TextDecorationStyle.double,
        decoration: TextDecoration.underline,
    ),
),''',
        ),
        Text(
          '文本虚线下划线',
          style: TextStyle(
            decorationStyle: TextDecorationStyle.dashed,
            decoration: TextDecoration.underline,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本虚线下划线',
    style: TextStyle(
        decorationStyle: TextDecorationStyle.dashed,
        decoration: TextDecoration.underline,
    ),
),''',
        ),
        Text(
          '文本点线下划线',
          style: TextStyle(
            decorationStyle: TextDecorationStyle.dotted,
            decoration: TextDecoration.underline,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本点线下划线',
    style: TextStyle(
        decorationStyle: TextDecorationStyle.dotted,
        decoration: TextDecoration.underline,
    ),
),''',
        ),
        Text(
          '文本实线下划线',
          style: TextStyle(
            decorationStyle: TextDecorationStyle.solid,
            decoration: TextDecoration.underline,
          ),
        ),
        ShowText(
          text: '''
 Text(
     '文本实线下划线',
     style: TextStyle(
         decorationStyle: TextDecorationStyle.solid,
         decoration: TextDecoration.underline,
     ),
 ),''',
        ),
        Text(
          '文本波浪线下划线',
          style: TextStyle(
            decorationStyle: TextDecorationStyle.wavy,
            decoration: TextDecoration.underline,
          ),
        ),
        ShowText(
          text: '''
 Text(
    '文本波浪线下划线',
    style: TextStyle(
        decorationStyle: TextDecorationStyle.wavy,
        decoration: TextDecoration.underline,
    ),
),''',
        ),
        Text('文本默认加粗',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        ShowText(
          text: '''
Text(
    '文本默认加粗', 
    style: TextStyle(
        fontWeight: FontWeight.bold,
    )
),''',
        ),
        Text(
          '文本粗细比重 w100 -- w900',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本粗细比重 w100 -- w900',
    style: TextStyle(
        fontWeight: FontWeight.w900,
    ),
),''',
        ),
        Text(
          '文本斜体字',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本斜体字', 
    style: TextStyle(
        fontStyle: FontStyle.italic,
    ),
),''',
        ),
        Text(
          '单词之间间隔，中文无效。How are you',
          style: TextStyle(
            wordSpacing: 20,
          ),
        ),
        ShowText(
          text: '''
Text(
    '单词之间间隔，中文无效。How are you', 
    style: TextStyle(
        wordSpacing: 20,
    ),
),''',
        ),
        Text(
          '文本字与字之间间隔',
          style: TextStyle(
            letterSpacing: 20,
          ),
        ),
        ShowText(
          text: '''
Text(
    '文本字与字之间间隔', 
    style: TextStyle(
        letterSpacing: 20,
    ),
),''',
        ),
        Text(
          '文本行高（字体倍数）',
          style: TextStyle(
            height: 1.5,
          ),
        ),
        ShowText(
          text: '''
Text('文本行高（字体倍数）',
    style: TextStyle(
        height: 1.5,
    ),
),''',
        ),
        Text.rich(
          TextSpan(
            text: '一行文字', // default text style
            children: <TextSpan>[
              TextSpan(
                text: '样式',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(
                text: '不同',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ShowText(
          text: '''
Text.rich(
    TextSpan(
        text: '一行文字', // default text style
        children: <TextSpan>[
            TextSpan(
                text: '样式', 
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                ),
            ),
            TextSpan(
                text: '不同', 
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                ),
            ),
        ],
    ),
),''',
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20) +
              MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }
}
