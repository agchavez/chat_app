import 'dart:ffi';

class User {
  bool online;
  String email;
  String name;
  String uid;
  String phone;
  int msj;

  User(
      {required this.email,
      required this.name,
      required this.msj,
      required this.phone,
      required this.online,
      required this.uid});
}
