import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto_board/screen/login_screen.dart';
import 'package:lotto_board/screen/splash_screen.dart';
import 'package:lotto_board/screen/dashboard/dashboard_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lotto_board/screen/components/navigation_drawer_widget.dart';
import 'package:lotto_board/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown,
  ]);
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  static final String title = 'Navigation Drawer';
  bool isValid = false; 
  checkLoggedInUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    if(token == null){
      isValid = true;
    }else{
      isValid = false;
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Lotto Board',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromRGBO(50, 75, 205, 1),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black87),
        canvasColor: secondaryColor,
      ),
    initialRoute: "/splashscreen",
    routes: <String, WidgetBuilder>{
      "/splashscreen": (_) => isValid == true ? LoginScreen() : SplashScreen(),
      "/dashboard": (_) => DashboardScreen(title: '',),
    }
  );
}