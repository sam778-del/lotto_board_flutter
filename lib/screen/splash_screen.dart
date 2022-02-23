import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {

  _checkUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _token = prefs.get("token");
      return _token;
  }

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, route);
  }

  _checkUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _token = prefs.get("token");
      return _token;
  }

  route() {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginScreen()
      ));
    // if(_checkUser() != ''){
    //   Navigator.pushReplacement(context, MaterialPageRoute(
    //     builder: (context) => MainApp()
    //   ));
    // }else{
    //   Navigator.pushReplacement(context, MaterialPageRoute(
    //     builder: (context) => LoginScreen()
    //   ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: new Color(0xFFFFFFFF),
                gradient: LinearGradient(colors: [(new  Color(0xFFFFFFFF)), new Color(0xFFFFFFFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
          ),
          Center(
            child: Container(
              child: Image.asset("images/app_logo.png"),
              height: 100,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}