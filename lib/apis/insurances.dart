import 'package:Myinshora/models/globals.dart';
import 'package:Myinshora/store/userMgt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

var message = "";

Future fetchInsurances() async {
  var uri = "user/applications";
  try {
    var token = await readToken();
    var response =
        await http.get(BASE + uri, headers: {'x-access-token': token});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      message = jsonResponse['message'];
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw e;
  }
}

Future fetchClaims() async {
  var uri = "insurance/claims";
  try {
    var token = await readToken();
    var response =
        await http.get(BASE + uri, headers: {'x-access-token': token});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      message = jsonResponse['message'];
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw e;
  }
}

Future deleteInsurance(app) async {
  var uri = "user/application/$app";
  try {
    var token = await readToken();
    var response =
        await http.delete(BASE + uri, headers: {'x-access-token': token});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      message = jsonResponse['message'];
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw e;
  }
}

Future getQuoteApi(body) async {
  var uri = "insurance/travel/quote";
  try {
    print("start");
    var token = await readToken();
    var response = await http
        .post(BASE + uri, body: body, headers: {'x-access-token': token});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      message = jsonResponse['message'];
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw e;
  }
}

Future upload(String fileName, String image, String app, String type) async {
  try {
    var postUri =
        Uri.parse(BASE + "user/uploadFile?applicationId=$app&uploadType=$type");
    http.MultipartRequest request = http.MultipartRequest('POST', postUri);
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('document', image);
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      return response;
    } else {
      throw "Request failed with status";
    }
  } catch (e) {
    throw e;
  }
}

Future buyPolicy(app) async {
  var uri = "insurance/policy/purchase";
  try {
    var token = await readToken();
    var body = convert.jsonEncode(app);
    var response = await http.post(BASE + uri,
        body: body,
        headers: {'x-access-token': token, 'Content-Type': "application/json"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      message = jsonResponse['message'];
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw e;
  }
}

Future apply(app) async {
  var uri = "user/apply";
  try {
    var token = await readToken();
    var body = convert.jsonEncode(app);
    var response = await http.post(BASE + uri,
        body: body,
        headers: {'x-access-token': token, 'Content-Type': "application/json"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      message = jsonResponse['message'];
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw e;
  }
}

Future getYears() async {
  var uri = "user/getYears";
  try {
    var token = await readToken();
    var response =
        await http.get(BASE + uri, headers: {'x-access-token': token});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      message = jsonResponse['message'];
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw e;
  }
}
