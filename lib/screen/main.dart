import 'package:lotto_board/constant.dart';
import 'package:lotto_board/controllers/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lotto_board/screen/dashboard/ghanaboard_screen.dart';
import 'package:lotto_board/screen/dashboard/dashboard_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuController(),
      child: MaterialApp(
          title: 'Lotto Board',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Color(0xffF5591F),
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
        initialRoute: "/dashboard",
        routes: <String, WidgetBuilder>{
          "/dashboard": (_) => DashboardScreen(title: '',),
        }
      ),
    );
  }
}
