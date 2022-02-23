import 'dart:convert';

import 'package:lotto_board/models/conversation_model.dart';
import 'package:lotto_board/models/message_model.dart';
import 'package:lotto_board/provider/base_provider.dart';
import 'package:lotto_board/services/conservation_service.dart';

class ConversationProvider extends BaseProvider {
  ConversationService _conversationService = ConversationService();
  List<ConversationModel> _concersations = [];
  List<ConversationModel> get concersations => _concersations;

  Future<List<ConversationModel>> getConversations() async {
    if (_concersations.isNotEmpty) return _concersations;
    setBusy(true);
    var response = await _conversationService.getConversations();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['data'].forEach((conversation) =>
          _concersations.add(ConversationModel.fromJson(conversation)));
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _concersations;
  }

  Future<void> storeMessage(MessageModal message) async {
    setBusy(true);
    var response = await _conversationService.storeMessage(message);
    // print(response.body);
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      setBusy(false);
      addMessageToConversation(
          message.conversationId, MessageModal.fromJson(data['data']));
    }
    setBusy(false);
  }

  addMessageToConversation(int conversationId, MessageModal message) {
    var conversation = _concersations
        .firstWhere((conversation) => conversation.id == conversationId);
    conversation.messages.add(message);
    toTheTop(conversation);
    notifyListeners();
  }

  toTheTop(ConversationModel conversation) {
    var index = _concersations.indexOf(conversation);

    for (var i = index; i > 0; i--) {
      var x = _concersations[i];
      _concersations[i] = _concersations[i - 1];
      _concersations[i - 1] = x;
    }
  }
}