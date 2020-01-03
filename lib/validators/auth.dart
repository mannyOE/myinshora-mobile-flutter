String emailValidator(String value) {
  String response;

  if (value.isEmpty) {
    response = "Field cannot be left empty";
  } else if (!value.contains("@")) {
    response = "Enter a valid Email address";
  } else {
    response = null;
  }
  return response;
}

String inputValidator(String value) {
  String response;
  if (value.isEmpty) {
    response = "Field cannot be left empty";
  } else {
    response = null;
  }
  return response;
}

String phoneValidator(String value) {
  String response;
  if (value.isEmpty) {
    response = "Field cannot be left empty";
  } else if (value.length < 11 || value.length > 11) {
    response = "Phone Number should be 11 Numbers";
  } else {
    response = null;
  }
  return response;
}

String passwordValidator(String value) {
  String response;
  if (value.isEmpty) {
    response = "Field cannot be left empty";
  } else if (value.length < 5) {
    response = "Password must be upto 5 characters";
  } else {
    response = null;
  }
  return response;
}
