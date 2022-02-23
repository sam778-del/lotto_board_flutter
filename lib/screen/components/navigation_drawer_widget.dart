import 'package:flutter/material.dart';
import 'package:lotto_board/screen/components/user_page.dart';
import 'package:lotto_board/screen/dashboard/dashboard_screen.dart';
import 'package:lotto_board/screen/dashboard/profile_screen.dart';
import 'package:lotto_board/screen/dashboard/ghanaboard_screen.dart';
import 'package:lotto_board/screen/dashboard/premierboard_screen.dart';
import 'package:lotto_board/screen/dashboard/classificationchart_screen.dart';
import 'package:lotto_board/screen/dashboard/prochat_screen.dart';
import 'package:lotto_board/screen/dashboard/chat_screen.dart';
import 'package:lotto_board/screen/dashboard/subscription_screen.dart';
import 'package:lotto_board/screen/login_screen.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:lotto_board/controllers/value.dart';
import 'package:lotto_board/controllers/logout.dart';
import 'dart:async';
import 'package:get/instance_manager.dart';
import 'package:lotto_board/screen/components/check_user.dart';
import 'package:lotto_board/screen/components/classification_chart.dart';

class NavigationDrawerWiget extends StatefulWidget {
  const NavigationDrawerWiget({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<NavigationDrawerWiget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  late Timer timer;

  @override
  void initState() {
    UserDataController.fetchDOData();
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => UserDataController.fetchDOData());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  ClassificationChart() async{
    showDialog(
      context: context,
      builder: (context) {
        return ClassificationDialog(
          mdFileName: 'classification_chart.jpeg',
        );
      },
    );
  }


  _checkPlan() async{
    setState(() {
      EdgeAlert.show(
        context, title: 'Error', 
        description: 'No active subscription.', 
        gravity: EdgeAlert.TOP,
        backgroundColor: Colors.pink,
        duration: EdgeAlert.LENGTH_VERY_LONG
      );
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubscriptionScreen(),
        ));
      });
    });
  }

  _checkProChat() async{
    setState(() {
      EdgeAlert.show(
        context, title: 'Error', 
        description: 'You have no access to Pro Chat', 
        gravity: EdgeAlert.TOP,
        backgroundColor: Colors.pink,
        duration: EdgeAlert.LENGTH_VERY_LONG
      );
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardScreen(title: ''),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = UserDataController.UserName;
    final email = UserDataController.UserEmail;
    final urlImage = 'https://img.favpng.com/8/19/8/united-states-avatar-organization-information-png-favpng-J9DvUE98TmbHSUqsmAgu3FpGw.jpg';

    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: name,
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Dashboard',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Ghanaboard',
                    icon: Icons.bar_chart,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Premierboard',
                    icon: Icons.bar_chart_sharp,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Classification Chart',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Chat',
                    icon: Icons.chat,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Pro Chat',
                    icon: Icons.chat,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Plans',
                    icon: Icons.money_off,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout_outlined,
                    onClicked: () => selectedItem(context, 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: name,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      text: email,
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );


  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardScreen(title: ''),
        ));
        break;
      case 1:
        if(UserDataController.UserPlan == '1')
          _checkPlan();
        else
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GhanaboardScreen(title: '',),
          ));
        break;
      case 2:
        if(UserDataController.UserPlan == '1')
          _checkPlan();
        else
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PremierboardScreen(title: ''),
          ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ClassificationChart(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatScreen(),
        ));
        break;
      case 5:
        if(UserDataController.ProChat == '0')
          _checkProChat();
        else
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProChatScreen(),
          ));
        break;
      case 8:
        _logOut();
        _completeLogin();
        break;
    }
  }

  Strings strings = Strings();
  Logout logout = Logout();
  _logOut() async{
    await logout.logoutUser();
  }

  _completeLogin() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const LoginScreen(),
      ),
    );
  }
}