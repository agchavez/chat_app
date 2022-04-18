import 'dart:convert';

MenssageResponse menssageResponseFromJson(String str) =>
    MenssageResponse.fromJson(json.decode(str));

String menssageResponseToJson(MenssageResponse data) =>
    json.encode(data.toJson());

class MenssageResponse {
  MenssageResponse({
    required this.ok,
    required this.mensajes,
  });

  bool ok;
  List<Mensaje> mensajes;

  factory MenssageResponse.fromJson(Map<String, dynamic> json) =>
      MenssageResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  Mensaje({
    required this.id,
    required this.from,
    required this.to,
    required this.createdAt,
    required this.updatedAt,
    required this.menssage,
  });

  String id;
  String from;
  String to;
  DateTime createdAt;
  DateTime updatedAt;
  String menssage;

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        id: json["_id"],
        from: json["from"],
        to: json["to"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        menssage: json["menssage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "from": from,
        "to": to,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "menssage": menssage,
      };
}
