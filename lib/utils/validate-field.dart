bool validatedEmail(String email) {
  if (email == "") {
    return false;
  }
  bool isEmailVaid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return isEmailVaid;
}

bool isInputEmpty(String value) {
  if (value == "") {
    return false;
  }
  return true;
}

bool validatedPhoneNumber(String value) {
  if (value == "") {
    return false;
  }
  bool isPhoneValid = RegExp(r"(\+504)?[839]{1}\d{7}").hasMatch(value);

  return isPhoneValid;
}
