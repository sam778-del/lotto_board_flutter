import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

class MyConnectivity {
var response;
Future<dynamic> connectivityChecker() async {
  var connected = 'failed';
    try {
      final result = await InternetAddress.lookup('google.com');
      final result2 = await InternetAddress.lookup('lottoboard.com.ng');
      final result3 = await InternetAddress.lookup('microsoft.com');
      if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty) ||
          (result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) ||
          (result3.isNotEmpty && result3[0].rawAddress.isNotEmpty)) {
        connected = 'connected';
      } else {
        connected = 'failed';
      }
    } on SocketException catch (_) {
      connected = 'failed';
    }
    this.response = connected;
    return null;
  }
}
