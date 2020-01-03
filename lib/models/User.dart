// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int accountType;
  String address;
  DateTime createdDate;
  DateTime dateOfBirth;
  String email;
  String firstName;
  String gender;
  bool invited;
  String lastName;
  String phone;
  String role;
  String title;
  int v;
  String id;

  User({
    this.accountType,
    this.address,
    this.createdDate,
    this.dateOfBirth,
    this.email,
    this.firstName,
    this.gender,
    this.title,
    this.invited,
    this.lastName,
    this.phone,
    this.role,
    this.v,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        accountType: json["accountType"],
        address: json["address"],
        createdDate: DateTime.parse(json["createdDate"]),
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        email: json["email"],
        firstName: json["firstName"],
        gender: json["gender"],
        invited: json["invited"],
        lastName: json["lastName"],
        phone: json["phone"],
        title: json["title"],
        role: json["role"],
        v: json["__v"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "accountType": accountType,
        "address": address,
        "title": title,
        "createdDate": createdDate.toIso8601String(),
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "email": email,
        "firstName": firstName,
        "gender": gender,
        "invited": invited,
        "lastName": lastName,
        "phone": phone,
        "role": role,
        "__v": v,
        "_id": id,
      };
}
