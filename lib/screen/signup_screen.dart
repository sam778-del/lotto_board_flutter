import 'package:flutter/material.dart';
import 'package:lotto_board/controllers/User.dart';
import 'package:lotto_board/controllers/value.dart';
import 'package:lotto_board/controllers/Animation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lotto_board/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {

  Strings strings = Strings();
  User user = User();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _PhoneController = new TextEditingController();

  bool _loading = false;
  bool _passwordVisible = false;

    _setData() async{
    if (_fbKey.currentState!.validate()) {
        setState(() {
          _loading = true;
          user.first_name = _firstnameController.text;
          user.last_name =  _lastnameController.text;
          user.email = _emailController.text;
          user.phone_number = _PhoneController.text;
          user.password = _passwordController.text;
        });
        await user.createUser();
        if(user.statusCode == 200){
          if(user.body["error"] == true)
          {
            setState(() {
              _loading = false;
              EdgeAlert.show(
                context, title: 'Error', 
                description: '${user.body["message"]}', 
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.pink,
                duration: EdgeAlert.LENGTH_VERY_LONG
              );
            });
          }else if(user.body["success"] == true){
            setState(() {
              _loading = false;
                EdgeAlert.show(
                  context, title: 'Success', 
                  description: '${user.body["message"]}', 
                  gravity: EdgeAlert.TOP,
                  backgroundColor: Colors.green,
                  duration: EdgeAlert.LENGTH_VERY_LONG
                );
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
          }else{
            setState(() {
              _loading = false;
              EdgeAlert.show(
                context, title: 'Error', 
                description: 'Your request cannot be processed, due to server error.', 
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.red,
                duration: EdgeAlert.LENGTH_VERY_LONG
              );
            });
          }
        }else if(user.statusCode == 500){
          setState(() {
            _loading = false;
            setState(() {
              _loading = false;
              EdgeAlert.show(
                context, title: 'Error', 
                description: '${user.body["message"]}', 
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.red,
                duration: EdgeAlert.LENGTH_VERY_LONG
              );
            });
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

  Widget initWidget() {
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
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
                  height: 50,
                  decoration: BoxDecoration(
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
                  child: Column(
                    children: [
                      FormBuilder(
                        key: _fbKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'first_name',
                              controller: _firstnameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffF5591F),
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Color(0xffF5591F),
                                ),
                                hintText: "First Name",
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
                  height: 50,
                  decoration: BoxDecoration(
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
                  child: new TextField(
                    controller: _lastnameController,
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Color(0xffF5591F),
                      ),
                      hintText: "Last Name",
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  decoration: BoxDecoration(
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
                  child: new TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color(0xffF5591F),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
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
                    controller: _PhoneController,
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      focusColor: Color(0xffF5591F),
                      icon: Icon(
                        Icons.phone,
                        color: Color(0xffF5591F),
                      ),
                      hintText: "Phone Number",
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
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

                GestureDetector(
                  onTap: () => {
                    _setData()
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
                        "REGISTER",
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
                      Text("Have Already Member?  "),
                      GestureDetector(
                        child: Text(
                          "Login Now",
                          style: TextStyle(
                              color: Color(0xffF5591F)
                          ),
                        ),
                        onTap: () {
                          // Write Tap Code Here.
                          Navigator.pop(context);
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