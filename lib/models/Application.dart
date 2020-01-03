// To parse this JSON data, do
//
//     final application = applicationFromJson(jsonString);

import 'dart:convert';

Application applicationFromJson(String str) =>
    Application.fromJson(json.decode(str));

String applicationToJson(Application data) => json.encode(data.toJson());

class Application {
  String id;
  double percent;
  List<Upload> uploads;
  String bouquet;
  bool activated;
  bool quoted;
  bool claimInProgress;
  bool complete;
  String agencyId;
  User user;
  Responses responses;
  SubClassCoverTypes subClassCoverTypes;
  DateTime createdDate;
  int v;
  Payment payment;
  String policy;

  Application({
    this.id,
    this.percent,
    this.uploads,
    this.bouquet,
    this.activated,
    this.quoted,
    this.complete,
    this.agencyId,
    this.user,
    this.responses,
    this.subClassCoverTypes,
    this.createdDate,
    this.v,
    this.claimInProgress,
    this.payment,
    this.policy,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    json.removeWhere((key, value) => value == 'null' || value == null);
    return Application(
      id: json.containsKey("_id") ? json["_id"] : "",
      claimInProgress:
          json.containsKey("claimInprogress") ? json["claimInprogress"] : false,
      uploads: json.containsKey("uploads")
          ? List<Upload>.from(json["uploads"].map((x) => Upload.fromJson(x)))
          : List<Upload>(),
      bouquet: json.containsKey("bouquet") ? json["bouquet"] : "",
      activated: json.containsKey("activated") ? json["activated"] : false,
      quoted: json.containsKey("quoted") ? json["quoted"] : false,
      complete: json.containsKey("complete") ? json["complete"] : false,
      agencyId: json.containsKey("agencyId") ? json["agencyId"] : "",
      payment: json.containsKey("payment")
          ? Payment.fromJson(json['payment'])
          : Payment(),
      responses: Responses.fromJson(json["responses"]),
      subClassCoverTypes:
          SubClassCoverTypes.fromJson(json["subClassCoverTypes"]),
      user: User.fromJson(json["user"]),
      policy: json.containsKey("policy") ? json["policy"] : "",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uploads": uploads != null
            ? List<dynamic>.from(uploads.map((x) => x.toJson()))
            : [],
        "bouquet": bouquet,
        "activated": activated,
        "quoted": quoted,
        "complete": complete,
        "user": user.toJson(),
        "responses": responses.toJson(),
        "subClassCoverTypes": subClassCoverTypes.toJson(),
      };
}

class Payment {
  String fullName;
  dynamic agentName;
  List<String> policies;
  String clientAddress;
  String clientEmail;
  String clientPhoneNumber;
  String wef;
  String wet;
  String totalAmount;
  String printPolicyUrl;
  dynamic printReceiptUrl;
  String hash;
  dynamic responseMessage;
  dynamic responseCode;
  bool polledToTq;

  Payment({
    this.fullName,
    this.agentName,
    this.policies,
    this.clientAddress,
    this.clientEmail,
    this.clientPhoneNumber,
    this.wef,
    this.wet,
    this.totalAmount,
    this.printPolicyUrl,
    this.printReceiptUrl,
    this.hash,
    this.responseMessage,
    this.responseCode,
    this.polledToTq,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    json.removeWhere((key, value) => value == 'null' || value == null);
    return Payment(
      policies: json.containsKey("policies")
          ? List<String>.from(json["policies"].map((x) => x))
          : List<String>(),
      clientAddress:
          json.containsKey("clientAddress") ? json["clientAddress"] : "",
      clientEmail: json.containsKey("clientEmail") ? json["clientEmail"] : "",
      clientPhoneNumber: json.containsKey("clientPhoneNumber")
          ? json["clientPhoneNumber"]
          : "",
      wef: json.containsKey("wef") ? json["wef"] : "",
      wet: json.containsKey("wet") ? json["wet"] : "",
      totalAmount: json.containsKey("totalAmount") ? json["totalAmount"] : "",
      printPolicyUrl:
          json.containsKey("printPolicyUrl") ? json["printPolicyUrl"] : "",
      printReceiptUrl:
          json.containsKey("printReceiptUrl") ? json["printReceiptUrl"] : "",
      hash: json.containsKey("hash") ? json["hash"] : "",
      responseMessage:
          json.containsKey("responseMessage") ? json["responseMessage"] : "",
      responseCode:
          json.containsKey("responseCode") ? json["responseCode"] : "",
    );
  }

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "agentName": agentName,
        "policies": List<dynamic>.from(policies.map((x) => x)),
        "clientAddress": clientAddress,
        "clientEmail": clientEmail,
        "clientPhoneNumber": clientPhoneNumber,
        "wef": wef,
        "wet": wet,
        "totalAmount": totalAmount,
        "printPolicyUrl": printPolicyUrl,
        "printReceiptUrl": printReceiptUrl,
        "hash": hash,
        "responseMessage": responseMessage,
        "responseCode": responseCode,
        "polledToTQ": polledToTq,
      };
}

class Responses {
  String destination;
  String quote;
  String bodyType;
  String make;
  String year;
  String insuranceType;
  String category;
  String numberPlate;
  String chasis;
  String engine;
  DateTime effectFrom;
  String model;
  String color;
  String identityType;
  String travelWithGroup;
  DateTime startDate;
  DateTime endDate;
  String variant;
  int sumAssured;
  int excess;
  int vehicleValue;
  String preMedicalCondition;
  String medicalCOndition;
  String travelPurpose;
  String nokName;
  String nokRelationship;
  String nokAddr;
  String passportNumber;
  DateTime passportExpiryDate;

  Responses({
    this.destination,
    this.quote,
    this.vehicleValue,
    this.bodyType,
    this.make,
    this.year,
    this.insuranceType,
    this.category,
    this.numberPlate,
    this.chasis,
    this.engine,
    this.effectFrom,
    this.passportExpiryDate,
    this.model,
    this.color,
    this.identityType,
    this.travelWithGroup,
    this.startDate,
    this.endDate,
    this.variant,
    this.sumAssured,
    this.excess,
    this.preMedicalCondition,
    this.travelPurpose,
    this.nokName,
    this.nokRelationship,
    this.nokAddr,
    this.passportNumber,
  });

  factory Responses.fromJson(Map<String, dynamic> json) {
    json.removeWhere((key, value) => value == 'null' || value == null);
    return Responses(
      destination: json.containsKey("destination") ? json["destination"] : "",
      quote: json.containsKey("quote") ? json["quote"].toString() : "",
      bodyType: json.containsKey("bodyType") ? json["bodyType"] : "",
      make: json.containsKey("make") ? json["make"] : "",
      vehicleValue: json.containsKey("vehicleValue") ? json["vehicleValue"] : 0,
      year: json.containsKey("year") ? json["year"] : "",
      insuranceType:
          json.containsKey("insuranceType") ? json["insuranceType"] : "",
      category: json.containsKey("category") ? json["category"] : "",
      numberPlate: json.containsKey("numberPlate") ? json["numberPlate"] : "",
      chasis: json.containsKey("chasis") ? json["chasis"] : "",
      engine: json.containsKey("engine") ? json["engine"] : "",
      effectFrom: json.containsKey("effectFrom")
          ? DateTime.parse(json["effectFrom"])
          : DateTime.now(),
      passportExpiryDate: json.containsKey('passportExpiryDate')
          ? DateTime.parse(json['passportExpiryDate'])
          : DateTime.now(),
      model: json.containsKey("model") ? json["model"] : "",
      color: json.containsKey("color") ? json["color"] : "",
      identityType:
          json.containsKey("identityType") ? json["identityType"] : "",
      travelWithGroup:
          json.containsKey("travelWithGroup") ? json["travelWithGroup"] : "",
      startDate: json.containsKey("startDate")
          ? DateTime.parse(json["startDate"])
          : DateTime.now(),
      endDate: json.containsKey("endDate")
          ? DateTime.parse(json["endDate"])
          : DateTime.now(),
      variant: json.containsKey("variant") ? json["variant"] : "",
      sumAssured: json.containsKey("sumAssured") ? json["sumAssured"] : 0,
      excess: json.containsKey("excess") ? json["excess"] : 0,
      preMedicalCondition: json.containsKey("preMedicalCondition")
          ? json["preMedicalCondition"]
          : "",
      travelPurpose:
          json.containsKey("travelPurpose") ? json["travelPurpose"] : "",
      nokName: json.containsKey("travelPurpose") ? json["nokName"] : "",
      nokRelationship:
          json.containsKey("nokRelationship") ? json["nokRelationship"] : "",
      nokAddr: json.containsKey("nokAddr") ? json["nokAddr"] : "",
      passportNumber: json.containsKey("nokAddr") ? json["passportNumber"] : "",
    );
  }

  Map<String, dynamic> toJson() => {
        "destination": destination,
        "quote": quote,
        "bodyType": bodyType,
        "make": make,
        "year": year,
        "insuranceType": insuranceType,
        "vehicleValue": vehicleValue,
        "category": category,
        "numberPlate": numberPlate,
        "chasis": chasis,
        "engine": engine,
        "effectFrom": effectFrom.toString(),
        "model": model,
        "passportExpiryDate": passportExpiryDate.toString(),
        "color": color,
        "identityType": identityType,
        "travelWithGroup": travelWithGroup,
        "startDate": startDate.toString(),
        "endDate": endDate.toString(),
        "variant": variant,
        "sumAssured": sumAssured,
        "excess": excess,
        "preMedicalCondition": preMedicalCondition,
        "travelPurpose": travelPurpose,
        "nokName": nokName,
        "nokRelationship": nokRelationship,
        "nokAddr": nokAddr,
        "passportNumber": passportNumber,
      };
}

class SubClassCoverTypes {
  String productId;
  String id;
  String productName;
  String subClassName;
  String coverTypeName;

  SubClassCoverTypes({
    this.productId,
    this.id,
    this.productName,
    this.subClassName,
    this.coverTypeName,
  });

  factory SubClassCoverTypes.fromJson(Map<String, dynamic> json) =>
      SubClassCoverTypes(
        productId: json["productId"],
        id: json["id"],
        productName: json["productName"],
        subClassName: json["subClassName"],
        coverTypeName: json["coverTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "id": id,
        "productName": productName,
        "subClassName": subClassName,
        "coverTypeName": coverTypeName,
      };
}

class Upload {
  String path;
  String type;

  Upload({
    this.path,
    this.type,
  });

  factory Upload.fromJson(Map<String, dynamic> json) => Upload(
        path: json["path"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "type": type,
      };
}

class User {
  bool invited;
  List<dynamic> insurancePlan;
  List<dynamic> claims;
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String gender;
  String address;
  String title;
  DateTime dateOfBirth;
  int accountType;
  String role;
  DateTime createdDate;
  int v;
  String fullName;

  User({
    this.invited,
    this.insurancePlan,
    this.claims,
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.gender,
    this.address,
    this.dateOfBirth,
    this.accountType,
    this.role,
    this.createdDate,
    this.v,
    this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        invited: json["invited"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        title: json["title"],
        phone: json["phone"],
        gender: json["gender"],
        address: json["address"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        accountType: json["accountType"],
        role: json["role"],
        createdDate: DateTime.parse(json["createdDate"]),
        v: json["__v"],
        fullName: json.containsKey("fullName") ? json["fullName"] : "",
      );

  Map<String, dynamic> toJson() => {
        "invited": invited,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "title": title,
        "gender": gender,
        "address": address,
        "dateOfBirth": dateOfBirth.toString(),
        "accountType": accountType,
        "role": role,
        "createdDate": createdDate.toString(),
        "fullName": fullName,
      };
}

class Country {
  String id;
  String name;

  Country({
    this.name,
    this.id,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
