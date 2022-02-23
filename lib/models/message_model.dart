class MessageModal {
  late int id;
  late String body;
  late int read;
  late int userId;
  late int conversationId;
  late String createdAt;
  late String updatedAt;

  MessageModal(
      {required this.id,
      required this.body,
      required this.read,
      required this.userId,
      required this.conversationId,
      required this.createdAt,
      required this.updatedAt});

  MessageModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    read = json['read'] == 'false' ? 0 : 1;
    userId = json['user_id'];
    conversationId = json['conversation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['read'] = this.read;
    data['user_id'] = this.userId;
    data['conversation_id'] = this.conversationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}