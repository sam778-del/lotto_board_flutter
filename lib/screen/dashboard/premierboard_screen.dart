import 'package:flutter/material.dart';
import 'package:lotto_board/constant.dart';
import 'package:lotto_board/screen/components/navigation_drawer_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:lotto_board/screen/components/premier_board.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'dart:async';
import 'package:get/instance_manager.dart';
import 'package:lotto_board/screen/components/shimmer_ghana.dart';
import 'package:get/get.dart';

class PremierboardScreen extends StatefulWidget {
  const PremierboardScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PremierboardScreen> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();
  final PremierController premierBoardData = Get.put(PremierController());
  late Timer timer;

  @override
  void initState() {
    premierBoardData.fetchPremierData();
    user.initData(premierBoardData.PremierBoardData);
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
       user.initData(premierBoardData.PremierBoardData);
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
        title: Text("Premier Board"),
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
        if(premierBoardData.isLoading == true)
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
                  leftHandSideColumnWidth: 50,
                  rightHandSideColumnWidth: MediaQuery.of(context).size.width / 36 * 350,
                  isFixedHeader: true,
                  headerWidgets: _getTitleWidget(),
                  leftSideItemBuilder: _generateFirstColumnRow,
                  rightSideItemBuilder: _generateRightHandSideColumnRow,
                  itemCount: user.userInfo.length,
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
                    premierBoardData.fetchPremierData();
                    user.initData(premierBoardData.PremierBoardData);
                    await Future.delayed(const Duration(milliseconds: 500));
                    _hdtRefreshController.refreshCompleted();
                  },
                  htdRefreshController: _hdtRefreshController,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
            '  ', MediaQuery.of(context).size.width / 36 * 19.444444444),
        onPressed: () {
          setState(() {});
        },
      ),
      _getTitleItemWidget('ROYAL', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('MARKII', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('ENUGU', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('LUCKY', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('TOTA', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('DIAMOND', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('PEOPLES', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('BINGO', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('METRO', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('INTERNATIONAL', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('GOLD', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('06', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('JACKPOT', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('CLUB MASTER', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('SUPER', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('VAG', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('FAIR CHANCE', MediaQuery.of(context).size.width / 36 * 19.444444444),
      _getTitleItemWidget('KING', MediaQuery.of(context).size.width / 36 * 19.444444444),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      color: Colors.blueGrey,
      child: Text(
        label, 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
      ),
      width: width,
      height: MediaQuery.of(context).size.height * 0.15,
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
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height * 0.10,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].royal_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].royal_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].markii_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].markii_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].enugu_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].enugu_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].lucky_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].lucky_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].tota_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].tota_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].diamond_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].diamond_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].peoples_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].peoples_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].bingo_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].bingo_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].metro_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].metro_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].international_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].international_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].gold_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].gold_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].o6_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].o6_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].jackpot_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].jackpot_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].club_master_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].club_master_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].super_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].super_machine}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].vag_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].vag_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].fair_chance_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].fair_chance_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${user.userInfo[index].king_machine} ', style: TextStyle(color: Color(0xFF363f93))),
                TextSpan(text: '${user.userInfo[index].king_wining}', style: TextStyle(color: Colors.red)),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w100
            ),
          ),
          width: MediaQuery.of(context).size.width / 36 * 19.444444444,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    )
    );
  }
}

User user = User();

class User {
  List<UserInfo> userInfo = [];
  int countData = 1;
  initData(premierBoardData) {
    userInfo = [];
    premierBoardData.asMap().forEach((index, value) 
      => userInfo.add(UserInfo("${index + countData}", value["royal_wining"], value["royal_machine"], value["markii_wining"], value["markii_machine"], value["enugu_wining"], value["enugu_machine"], value["lucky_wining"], value["lucky_machine"], value["tota_wining"], value["tota_machine"], value["diamond_wining"], value["diamond_machine"], value["peoples_wining"], value["peoples_machine"], value["bingo_wining"], value["bingo_machine"], value["metro_wining"], value["metro_machine"], value["international_wining"], value["international_machine"], value["gold_wining"], value["gold_machine"], value["o6_wining"], value["o6_machine"], value["jackpot_wining"], value["jackpot_machine"], value["club_master_wining"], value["club_master_machine"], value["super_wining"], value["super_machine"], value["vag_wining"], value["vag_machine"], value["fair_chance_wining"], value["fair_chance_machine"], value["king_wining"], value["king_machine"]))
    );
  }
}

class UserInfo {
  String name;
  String royal_machine;
  String royal_wining;
  String markii_machine;
  String markii_wining;
  String enugu_machine;
  String enugu_wining;
  String lucky_machine;
  String lucky_wining;
  String tota_machine;
  String tota_wining;
  String diamond_machine;
  String diamond_wining;
  String peoples_machine;
  String peoples_wining;
  String bingo_machine;
  String bingo_wining;
  String metro_machine;
  String metro_wining;
  String international_machine;
  String international_wining;
  String gold_machine;
  String gold_wining;
  String o6_machine;
  String o6_wining;
  String jackpot_machine;
  String jackpot_wining;
  String club_master_machine;
  String club_master_wining;
  String super_machine;
  String super_wining;
  String vag_machine;
  String vag_wining;
  String fair_chance_machine;
  String fair_chance_wining;
  String king_machine;
  String king_wining;


  UserInfo(
    this.name,
    this.royal_machine,
    this.royal_wining,
    this.markii_machine,
    this.markii_wining,
    this.enugu_machine,
    this.enugu_wining,
    this.lucky_machine,
    this.lucky_wining,
    this.tota_machine,
    this.tota_wining,
    this.diamond_machine,
    this.diamond_wining,
    this.peoples_machine,
    this.peoples_wining,
    this.bingo_machine,
    this.bingo_wining,
    this.metro_machine,
    this.metro_wining,
    this.international_machine,
    this.international_wining,
    this.gold_machine,
    this.gold_wining,
    this.o6_machine,
    this.o6_wining,
    this.jackpot_machine,
    this.jackpot_wining,
    this.club_master_machine,
    this.club_master_wining,
    this.super_machine,
    this.super_wining,
    this.vag_machine,
    this.vag_wining,
    this.fair_chance_machine,
    this.fair_chance_wining,
    this.king_machine,
    this.king_wining
  );
}