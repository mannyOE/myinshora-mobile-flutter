import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/models/globals.dart';
import 'package:Myinshora/store/userMgt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

List<dynamic> genders, years, ids = [];
List<String> makes = new List<String>();

Future<List<Gender>> fetchGenders() async {
  var uri = "user/getGenders";
  var response = await http.get(BASE + uri);
  if (response.statusCode == 200) {
    final items = convert
        .jsonDecode(response.body)['genders']
        .cast<Map<String, dynamic>>();
    List<Gender> listOfGenders = items.map<Gender>((gender) {
      return Gender.fromJson(gender);
    }).toList();
    return listOfGenders;
  } else {
    throw Exception("Could not Load list of genders");
  }
}

Future<List<Country>> fetchCountries() async {
  var uri = "user/getCountries";

  var response = await http.get(BASE + uri);
  if (response.statusCode == 200) {
    final items = convert
        .jsonDecode(response.body)['countries']
        .cast<Map<String, dynamic>>();
    List<Country> listOfCountries = items.map<Country>((gender) {
      return Country.fromJson(gender);
    }).toList();
    return listOfCountries;
  } else {
    throw Exception("Could not Load list of countries");
  }
}

Future<List<Category>> fetchCategories() async {
  var uri = "user/getCategories";

  var response = await http.get(BASE + uri);
  if (response.statusCode == 200) {
    final items = convert.jsonDecode(response.body)['categories'];
    List<Category> listOfCats = items.map<Category>((cat) {
      return Category.fromJson(cat);
    }).toList();
    return listOfCats;
  } else {
    throw Exception("Could not Load list of countries");
  }
}

Future<List<String>> fetchBodyTypes() async {
  var uri = "user/getBodies";

  var response = await http.get(BASE + uri);
  if (response.statusCode == 200) {
    final items = convert.jsonDecode(response.body)['bodyTypes'];
    List<String> listOfBodyTypes = items.map<String>((body) {
      return body.toString();
    }).toList();
    return listOfBodyTypes;
  } else {
    throw Exception("Could not Load list of countries");
  }
}

Future<List<String>> fetchYears() async {
  var uri = "user/getYears";

  var response = await http.get(BASE + uri);
  if (response.statusCode == 200) {
    final items = convert.jsonDecode(response.body)['manuFactureYear'];
    List<String> listOfYears = items.map<String>((body) {
      return body.toString();
    }).toList();
    return listOfYears;
  } else {
    throw Exception("Could not Load list of countries");
  }
}

Future<List<String>> fetchMakes(year) async {
  var uri = "user/getVehicleMake?year=$year";

  try {
    var response = await http.get(BASE + uri);
    if (response.statusCode == 200) {
      final items = convert.jsonDecode(response.body);
      List<String> listOfMakes = items.map<String>((body) {
        return body.toString();
      }).toList();
      makes = listOfMakes;
      return listOfMakes;
    } else {
      throw Exception("Could not Load list of countries");
    }
  } catch (e) {
    throw Exception(e["message"]);
  }
}

Future<List<String>> fetchModels(year, make) async {
  var uri = "user/getVehicleModel?year=$year&make=$make";

  try {
    var response = await http.get(BASE + uri);
    if (response.statusCode == 200) {
      final items = convert.jsonDecode(response.body);
      List<String> listOfModels = items.map<String>((body) {
        return body.toString();
      }).toList();
      return listOfModels;
    } else {
      throw Exception("Could not Load list of countries");
    }
  } catch (e) {
    throw Exception(e["message"]);
  }
}

Future<List<String>> fetchColors() async {
  var uri = "user/getColors";

  try {
    var response = await http.get(BASE + uri);
    if (response.statusCode == 200) {
      final items = convert.jsonDecode(response.body)['colors'];
      List<String> listOfColors = items.map<String>((body) {
        return body.toString();
      }).toList();
      return listOfColors;
    } else {
      throw Exception("Could not Load list of countries");
    }
  } catch (e) {
    throw Exception(e["message"]);
  }
}

Future<List<Titles>> fetchTitles() async {
  var uri = "user/getTitles";

  var response = await http.get(BASE + uri);
  if (response.statusCode == 200) {
    final items = convert
        .jsonDecode(response.body)['titles']
        .cast<Map<String, dynamic>>();
    List<Titles> listOfTitles = items.map<Titles>((gender) {
      return Titles.fromJson(gender);
    }).toList();
    return listOfTitles;
  } else {
    throw Exception("Could not Load list of countries");
  }
}

register(body) async {
  var uri = "auth/register";
  try {
    var response = await http.post(BASE + uri,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode(body));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      return jsonResponse;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw e;
  }
}

login(body) async {
  var uri = "auth/login";

  try {
    var response = await http.post(BASE + uri,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode(body));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      if (jsonResponse['data'] != null) {
        await saveUser(jsonResponse['data']['user']);
        saveToken(jsonResponse['data']['token']);
      }

      return jsonResponse;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    print(e);
    throw Exception("Unable to save user");
  }
}

updateUser(body) async {
  var uri = "auth/update";
  try {
    var token = await readToken();
    var response = await http.put(BASE + uri,
        headers: {'x-access-token': token, 'Content-Type': "application/json"},
        body: convert.jsonEncode(body));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      await saveUser(jsonResponse['result']);
      return jsonResponse;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      // itemCount = convert.jsonEncode(itemCount);
      throw "Request failed with status: ${jsonResponse['message']}.";
    }
  } catch (e) {
    throw Exception("Unable to save user");
  }
}
