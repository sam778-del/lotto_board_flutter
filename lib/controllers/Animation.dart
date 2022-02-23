import 'package:lotto_board/controllers/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  static Future<bool> userCreateToast(){
    return Fluttertoast.showToast(
        msg: "Registration Successfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static Future<bool> userUpdateToast(){
    return Fluttertoast.showToast(
        msg: "Information Updated Succesfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}