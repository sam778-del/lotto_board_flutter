import 'package:lotto_board/models/message_model.dart';
import 'package:lotto_board/models/user_model.dart';

class ConversationModel {
  late int id;
  late UserModel user;
  late String createdAt;
  late List<MessageModal> messages;

  ConversationModel({required this.id, required this.user, required this.createdAt, required this.messages});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = (json['user'] != null ? new UserModel.fromJson(json['user']) : null)!;
    createdAt = json['created_at'];
    if (json['messages'] != null) {
      messages = <MessageModal>[];
      json['messages'].forEach((v) {
        messages.add(new MessageModal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['created_at'] = this.createdAt;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}