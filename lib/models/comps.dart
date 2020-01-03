import 'dart:convert';

Comp compFromJson(String str) => Comp.fromJson(json.decode(str));

String compToJson(Comp data) => json.encode(data.toJson());

class Comp {
  int type;
  String name;
  int color;
  String message;
  String cta;
  String bouquet;

  Comp(
      {this.name, this.type, this.color, this.message, this.cta, this.bouquet});

  factory Comp.fromJson(Map<String, dynamic> json) => Comp(
        name: json["name"],
        type: json["type"],
        color: json["color"],
        message: json["message"],
        cta: json["cta"],
        bouquet: json["bouquet"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
        "type": type,
        "message": message,
        "cta": cta,
        "bouquet": bouquet
      };
}
