import 'dart:convert';
List<GhanaBoard> GhanaBoardFromJson(String str) =>
    List<GhanaBoard>.from(json.decode(str).map((x) => GhanaBoard.fromJson(x)));

String GhanaBoardToJson(List<GhanaBoard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GhanaBoard {
  GhanaBoard({
    required this.id, 
    required this.m_s_p_1,
    required this.m_s_p_2,
    required this.lucky_gee_1,
    required this.lucky_gee_2,
    required this.mid_week_1,
    required this.mid_week_2,
    required this.fortune_1,
    required this.fortune_2,
    required this.bonaza_1,
    required this.bonaza_2,
    required this.national_1,
    required this.national_2,
  });

  int id;
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

  factory GhanaBoard.fromJson(Map<String, dynamic> json) => GhanaBoard(
    id: json["id"] == null ? null : json["id"],
    m_s_p_1: json["m_s_p_1"] == null ? '' : json["m_s_p_1"],
    m_s_p_2: json["m_s_p_2"] == null ? '' : json["m_s_p_2"],
    lucky_gee_1: json["lucky_gee_1"] == null ? '' : json["lucky_gee_1"],
    lucky_gee_2: json["lucky_gee_2"] == null ? '' : json["lucky_gee_2"],
    mid_week_1: json["mid_week_1"] == null ? '' : json["mid_week_1"],
    mid_week_2: json["mid_week_2"] == null ? '' : json["mid_week_2"],
    fortune_1: json["fortune_1"] == null ? '' : json["fortune_1"],
    fortune_2: json["fortune_2"] == null ? '' : json["fortune_2"],
    bonaza_1: json["bonaza_1"] == null ? '' : json["bonaza_1"],
    bonaza_2: json["bonaza_2"] == null ? '' : json["bonaza_2"],
    national_1: json["national_1"] == null ? '' : json["national_1"],
    national_2: json["national_2"] == null ? '' : json["national_2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? '' : id,
    "m_s_p_1": m_s_p_1 == null ? '' : m_s_p_1,
    "m_s_p_2": m_s_p_2 == null ? '' : m_s_p_2,
    "lucky_gee_1": lucky_gee_1 == null ? '' : lucky_gee_1,
    "lucky_gee_2": lucky_gee_2 == null ? '' : lucky_gee_2,
    "mid_week_1": mid_week_1 == null ? '' : mid_week_1,
    "mid_week_2": mid_week_2 == null ? '' : mid_week_2,
    "fortune_1": fortune_1 == null ? '' : fortune_1,
    "fortune_2": fortune_2 == null ? '' : fortune_2,
    "bonaza_1":  bonaza_1 == null ? '' : bonaza_1,
    "bonaza_2": bonaza_2 == null ? '' : bonaza_2,
    "national_1": national_1 == null ? '' : national_1,
    "national_2": national_2 == null ? '' : national_2,
  };
}