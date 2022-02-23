import 'package:flutter/material.dart';
import 'package:lotto_board/provider/conversation_provider.dart';
import 'package:lotto_board/provider/locator.dart';
import 'package:lotto_board/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  // ChangeNotifierProvider(
  //   builder: (context) => locator<ConversationProvider>(), create: (BuildContext context) {  },
  // ),
  // ChangeNotifierProvider(
  //   builder: (context) => locator<UserProvider>(), create: (BuildContext context) {  },
  // ),
];