

import 'package:flutter/material.dart';
import 'package:flutter_introduce/all/my_radio.dart';
import 'package:flutter_introduce/all/my_text.dart';

class Data {
  static List<Model> allDataModel = [
    Model(Icon(Icons.text_format), "Text", MyText()),
    Model(Icon(Icons.radio_button_checked), "Radio", MyRadio()),
    Model(Icon(Icons.check_box), "CheckBox", MyText()),
    Model(Icon(Icons.add_box), "Button", MyText()),
    Model(Icon(Icons.switch_camera), "Switch", MyText()),
    Model(Icon(Icons.input), "Input", MyText()),
    Model(Icon(Icons.image), "Image", MyText()),
    Model(Icon(Icons.insert_emoticon), "Icon", MyText()),
  ];
}

class Model {
  Widget widget;
  String name;
  Widget page;
  Model(this.widget, this.name, this.page);
}