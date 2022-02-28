import 'package:lotto_board/responsive.dart';
import 'package:flutter/material.dart';
import 'package:lotto_board/constant.dart';
import 'package:get/instance_manager.dart';
import 'package:lotto_board/screen/components/shimmer_ghana.dart';
import 'package:get/get.dart';
import 'package:lotto_board/screen/components/navigation_drawer_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:lotto_board/models/conversation_model.dart';
import 'package:lotto_board/screen/components/check_user.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ChatScreen> {
@override
  void initState() {
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavigationDrawerWiget(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Conversations'),
        centerTitle: true,
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
    return Center();
  }
}