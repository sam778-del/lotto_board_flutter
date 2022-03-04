import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lotto_board/constant.dart';
import 'package:lotto_board/screen/components/navigation_drawer_widget.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:lotto_board/controllers/value.dart';
import 'package:edge_alert/edge_alert.dart';
import '../login_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotto_board/screen/components/ghana_board.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:lotto_board/controllers/logout.dart';
import 'package:lotto_board/screen/components/shimmer_ghana.dart';

class GhanaboardScreen extends StatefulWidget {
  const GhanaboardScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<GhanaboardScreen> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();
  final GhanaController ghanaBoardData = Get.put(GhanaController());


  late Timer timer;

  @override
  void initState() {
    ghanaBoardData.fetchCarousel();
    user.initData(ghanaBoardData.GhanaBoardData);
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
       user.initData(ghanaBoardData.GhanaBoardData);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavigationDrawerWiget(),
      appBar: AppBar(
        title: Text("Ghana Board"),
        backgroundColor: Color(0xFF363f93),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: _getBodyWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBodyWidget() {
    return SingleChildScrollView(
      child: Obx(() {
        if(ghanaBoardData.isLoading == true)
          return CarouselLoading();
        else
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: 35,
                  rightHandSideColumnWidth: 665,
                  isFixedHeader: true,
                  headerWidgets: _getTitleWidget(),
                  leftSideItemBuilder: _generateFirstColumnRow,
                  rightSideItemBuilder: _generateRightHandSideColumnRow,
                  itemCount: ghanaBoardData.GhanaBoardData.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black54,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: Colors.blueGrey,
                  rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                  verticalScrollbarStyle: const ScrollbarStyle(
                    isAlwaysShown: true,
                    thickness: 4.0,
                    radius: Radius.circular(5.0),
                  ),
                  horizontalScrollbarStyle: const ScrollbarStyle(
                    isAlwaysShown: true,
                    thickness: 4.0,
                    radius: Radius.circular(5.0),
                  ),
                  enablePullToRefresh: true,
                  refreshIndicator: const WaterDropHeader(),
                  refreshIndicatorHeight: 60,
                  onRefresh: () async {
                    ghanaBoardData.fetchCarousel();
                    user.initData(ghanaBoardData.GhanaBoardData);
                    await Future.delayed(const Duration(milliseconds: 500));
                    _hdtRefreshController.refreshCompleted();
                  },
                  htdRefreshController: _hdtRefreshController,
                ),
                height: MediaQuery.of(context).size.height,
              )
            ]
          );
      })
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '  ', 35),
        onPressed: () {
          setState(() {});
        },
      ),
      _getTitleItemWidget('M.S.P', MediaQuery.of(context).size.width / 36 * 11.0833333333),
      _getTitleItemWidget('LUCKY GEE', MediaQuery.of(context).size.width / 36 * 11.0833333333),
      _getTitleItemWidget('MID WEEK', MediaQuery.of(context).size.width / 36 * 11.0833333333),
      _getTitleItemWidget('FORTUNE', MediaQuery.of(context).size.width / 36 * 11.0833333333),
      _getTitleItemWidget('BONAZA', MediaQuery.of(context).size.width / 36 * 11.0833333333),
      _getTitleItemWidget('NATIONAL', MediaQuery.of(context).size.width / 36 * 11.0833333333),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      color: Colors.blueGrey,
      child: Text(
        label, 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        )
      ),
      width: width,
      height: MediaQuery.of(context).size.height * 0.10,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(
        user.userInfo[index].name,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      width:20,
      height: MediaQuery.of(context).size.height * 0.10,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].m_s_p_1} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].m_s_p_2}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 11.0833333333,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].lucky_gee_1} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].lucky_gee_2}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 11.0833333333,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].mid_week_1} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].mid_week_2}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 11.0833333333,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].fortune_1} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].fortune_2}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 11.0833333333,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].bonaza_1} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].bonaza_2}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 11.0833333333,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].national_1} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].national_2}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 11.0833333333,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}

User user = User();

class User {
  List<UserInfo> userInfo = [];
  int countData = 1;
  initData(ghanaBoardData) {
    userInfo = [];
    ghanaBoardData.asMap().forEach((index, value) 
      => userInfo.add(UserInfo("${index + countData}", value["m_s_p_1"], value["m_s_p_2"], value["lucky_gee_1"], value["lucky_gee_2"], value["mid_week_1"], value["mid_week_2"], value["fortune_1"], value["fortune_2"], value["bonaza_1"], value["bonaza_2"], value["national_1"], value["national_2"]))
    );
  }
}

class UserInfo {
  String name;
  String m_s_p_1;
  String m_s_p_2;
  String lucky_gee_1;
  String lucky_gee_2;
  String mid_week_1;
  String mid_week_2;
  String fortune_1;
  String fortune_2;
  String bonaza_1;
  String bonaza_2;
  String national_1;
  String national_2;

  UserInfo(
    this.name, 
    this.m_s_p_1,
    this.m_s_p_2,
    this.lucky_gee_1,
    this.lucky_gee_2,
    this.mid_week_1,
    this.mid_week_2,
    this.fortune_1,
    this.fortune_2,
    this.bonaza_1,
    this.bonaza_2,
    this.national_1,
    this.national_2,
  );
}

