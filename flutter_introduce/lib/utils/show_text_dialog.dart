import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCode(BuildContext context, String text) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return ShowDialog(text: text);
      });
}

class ShowDialog extends StatefulWidget {
  final String text;
  ShowDialog({Key key, this.text}) : super(key: key);

  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  double size = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              if (size <= 20) {
                setState(() {
                  size += 1;
                });
              }
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              if (size >= 10) {
                setState(() {
                  size -= 1;
                });
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
              left: 10,
              right: 10),
          width: double.infinity,
          // margin: EdgeInsets.all(10),
          child: Text(widget.text, style: TextStyle(fontSize: size)),
        ),
      ),
    );
  }
}
