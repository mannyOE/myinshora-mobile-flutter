// To parse this JSON data, do
//
//     final claims = claimsFromJson(jsonString);

import 'dart:convert';

ClaimsModel claimsFromJson(String str) =>
    ClaimsModel.fromJson(json.decode(str));

String claimsToJson(ClaimsModel data) => json.encode(data.toJson());

class ClaimsModel {
  String id;
  String status;
  List<Upload> uploads;
  String application;
  String detailsofIncident;
  String driverSide;
  String carCenter;
  String passengerSide;
  String estimateofRepairs;
  String locationofOccurrence;
  String policyNumber;
  String previousClaim;
  String timeofIncident;
  String user;
  String vehicleRegNumber;
  DateTime createdDate;
  int v;

  ClaimsModel({
    this.id,
    this.status,
    this.uploads,
    this.application,
    this.detailsofIncident,
    this.driverSide,
    this.carCenter,
    this.passengerSide,
    this.estimateofRepairs,
    this.locationofOccurrence,
    this.policyNumber,
    this.previousClaim,
    this.timeofIncident,
    this.user,
    this.vehicleRegNumber,
    this.createdDate,
    this.v,
  });

  factory ClaimsModel.fromJson(Map<String, dynamic> json) {
    json.removeWhere((key, value) => value == 'null' || value == null);
    return ClaimsModel(
      id: json["_id"],
      status: json["status"],
      uploads:
          List<Upload>.from(json["uploads"].map((x) => Upload.fromJson(x))),
      application: json["application"],
      detailsofIncident: json["detailsofIncident"],
      driverSide: json["driverSide"],
      carCenter: json["carCenter"],
      passengerSide: json["passengerSide"],
      estimateofRepairs: json["estimateofRepairs"],
      locationofOccurrence: json["locationofOccurrence"],
      policyNumber: json["policyNumber"],
      previousClaim: json["previousClaim"],
      timeofIncident: json["timeofIncident"],
      user: json["user"],
      vehicleRegNumber: json["vehicleRegNumber"],
      createdDate: DateTime.parse(json["createdDate"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "status": status,
      "uploads": List<dynamic>.from(uploads.map((x) => x.toJson())),
      "application": application,
      "detailsofIncident": detailsofIncident,
      "driverSide": driverSide,
      "carCenter": carCenter,
      "passengerSide": passengerSide,
      "estimateofRepairs": estimateofRepairs,
      "locationofOccurrence": locationofOccurrence,
      "policyNumber": policyNumber,
      "previousClaim": previousClaim,
      "timeofIncident": timeofIncident,
      "user": user,
      "vehicleRegNumber": vehicleRegNumber,
      "createdDate": createdDate.toIso8601String(),
      "__v": v,
    };
  }
}

class Upload {
  String path;

  Upload({
    this.path,
  });

  factory Upload.fromJson(Map<String, dynamic> json) => Upload(
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
      };
}
