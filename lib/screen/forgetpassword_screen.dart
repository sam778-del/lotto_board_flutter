import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lotto_board/screen/login_screen.dart';
import 'package:lotto_board/controllers/value.dart';
import 'package:lotto_board/controllers/Password.dart';
import 'package:lotto_board/controllers/Animation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/rendering.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<ForgetPasswordScreen> {
  Strings strings = Strings();
  Password password = Password();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  TextEditingController _emailController = new TextEditingController();
  
  bool _loading = false;
  bool _passwordVisible = false;

  _setPassword() async {
    if(_fbKey.currentState!.validate()){
      setState(() {
        _loading = true;
        password.email = _emailController.text;
      });
      await password.changePassword();
      if(password.statusCode == 200){
          setState(() {
            _loading = false;
            EdgeAlert.show(
              context, title: 'Success', 
              description: '${password.body["message"]}', 
              gravity: EdgeAlert.TOP,
              backgroundColor: Colors.green,
              duration: EdgeAlert.LENGTH_VERY_LONG
            );
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }else if(password.statusCode == 500){
          setState(() {
            _loading = false;
            EdgeAlert.show(
              context, title: 'Error', 
              description: '${password.body["message"]}', 
              gravity: EdgeAlert.TOP,
              backgroundColor: Colors.red,
              duration: EdgeAlert.LENGTH_VERY_LONG
            );
          });
      }else if(password.statusCode == 404){
          setState(() {
            _loading = false;
            EdgeAlert.show(
              context, title: 'Error', 
              description: '${password.body["message"]}', 
              gravity: EdgeAlert.TOP,
              backgroundColor: Colors.pink,
              duration: EdgeAlert.LENGTH_VERY_LONG
            );
          });
      }else if(password.statusCode == 400){
          setState(() {
            _loading = false;
            EdgeAlert.show(
              context, title: 'Error', 
              description: '${password.body["message"]}', 
              gravity: EdgeAlert.TOP,
              backgroundColor: Colors.pink,
              duration: EdgeAlert.LENGTH_VERY_LONG
            );
          });
      }else {
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
    return InitWidget();
  }

  InitWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              margin: EdgeInsets.only(left: 20, right: 20, top: 60),
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

          GestureDetector(
              onTap: () {
                _setPassword();
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 70),
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
                  "Reset Password",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have An Account?  "),
                  GestureDetector(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Color(0xffF5591F)
                      ),
                    ),
                    onTap: () {
                      // Write Tap Code Here.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
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
    ); 
  }
}