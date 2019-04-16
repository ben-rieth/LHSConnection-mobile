import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Post {

  String title;
  String text;
  File image;
  DateTime timeStamp;

  Post({this.title, this.text, this.image, this.timeStamp});
}