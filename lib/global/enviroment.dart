import 'dart:io';

class Enviroment {
  static String apiurl = Platform.isAndroid
      ? 'http://10.0.2.2:8080/api'
      : 'http://localhost:8080/api';

  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://localhost:8080';
}
