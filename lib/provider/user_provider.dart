import 'dart:convert';

import 'package:lotto_board/models/user_model.dart';
import 'package:lotto_board/provider/base_provider.dart';
import 'package:lotto_board/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends BaseProvider {
  UserModel _user = UserModel(email: '', password: '', name: '', id: 0);
  UserService _userService = UserService();

  UserModel get user => _user;

  setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> updateUser() async {
    setBusy(true);
    var response = await _userService.updateUser(_user);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setUser(UserModel.fromJson(data['data']));

      setBusy(false);
      return true;
    }
    if (response.statusCode == 422) {
      var message = data['errors']['email'][0];
      print(message);
      setMessage(message);
      return false;
    }
    setBusy(false);
    return false;
  }

  Future<void> setFcmToken(String token) async {
    _userService.setFcmToken(token);
  }
}