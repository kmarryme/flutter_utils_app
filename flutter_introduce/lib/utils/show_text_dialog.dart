
import 'package:flutter/material.dart';


showCode(BuildContext context, String text){
  showDialog(
    context: context,
    builder: (context){
      return ShowDialog(text: text);
    }
  );
}

class ShowDialog extends StatefulWidget {
  final String text;
  ShowDialog({Key key, this.text}) : super(key: key);

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Text(widget.text),
        ),
      ),
    );
  }
}