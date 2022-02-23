import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lotto_board/screen/dashboard/dashboard_screen.dart';
import 'package:lotto_board/screen/signup_screen.dart';
import 'package:lotto_board/screen/forgetpassword_screen.dart';
import 'package:lotto_board/controllers/Auth.dart';
import 'package:lotto_board/controllers/value.dart';
import 'package:lotto_board/controllers/Animation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lotto_board/screen/components/no_internet.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:edge_alert/edge_alert.dart';
import 'package:lotto_board/controllers/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginScreen> {
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  

  Strings strings = Strings();
  Auth auth = Auth();
  MyConnectivity checkConnection = MyConnectivity();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  
  bool _loading = false;
  bool _passwordVisible = false;
  bool _connectStatus = false;

  _setLogin() async {
      if (_fbKey.currentState!.validate()) {
        setState(() {
          _loading = true;
          auth.email = _emailController.text;
          auth.password = _passwordController.text;
        });
        await auth.auth();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", auth.body["token"]);
        String _token = prefs.get("token");
          if(auth.statusCode == 400){
            setState(() {
              _loading = false;
              EdgeAlert.show(
                context, title: 'Error', 
                description: '${auth.body["message"]}', 
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.pink,
                duration: EdgeAlert.LENGTH_VERY_LONG
              );
            });
          } else if(auth.statusCode == 500){
            setState(() {
              _loading = false;
              EdgeAlert.show(
                context, title: 'Error', 
                description: '${auth.body["message"]}', 
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.red,
                duration: EdgeAlert.LENGTH_VERY_LONG
              );
            });
          } else if(auth.statusCode == 200 && _token != '') {
            setState(() {
              _loading = false;
              EdgeAlert.show(
                context, title: 'Success', 
                description: '${auth.body["message"]}', 
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.green,
                duration: EdgeAlert.LENGTH_VERY_LONG
              );
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen(title: '',)));
          } else{
            setState(() {
              _loading = false;
              EdgeAlert.show(
                context, title: 'Error', 
                description: 'Please check back later! Something Went Wrong.', 
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.red,
                duration: EdgeAlert.LENGTH_VERY_LONG
              );
            }); 
          }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return initWidget();
      },
    );
  }

  initWidget() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
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
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 27.h,
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 9.h, bottom: 2.h),
                            child: Image.asset(
                              "images/app_logo.png",
                              height: 15.h,
                              width: 15.h,
                            ),
                          ),
                        ],
                      )
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      FormBuilder(
                        key: _fbKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'email',
                              controller: _emailController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffF5591F),
                              decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Color(0xffF5591F),
                              ),
                                hintText: "Enter Email",
                                hintStyle: TextStyle(color: Colors.black),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xffF5591F),
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      focusColor: Color(0xffF5591F),
                      icon: Icon(
                        Icons.vpn_key,
                        color: Color(0xffF5591F),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                          color: Color(0xffF5591F),
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                              _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen(),
                        )
                      );
                    },
                    child: Text("Forget Password?"),
                  ),
                ),

                GestureDetector(
                  onTap: () => {
                    _setLogin()
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 60),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [(new  Color(0xffF5591F)), new Color(0xffF2861E)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight
                      ),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: _loading == true ? Animations.loading() : Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't Have Any Account?  "),
                      GestureDetector(
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: Color(0xffF5591F)
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            )
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}