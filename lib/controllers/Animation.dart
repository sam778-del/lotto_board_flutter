import 'package:lotto_board/controllers/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Strings strings = Strings();

class Animations{

  static Widget loading(){
    return Container(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          backgroundColor:Colors.green,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        )
    );
  }
}