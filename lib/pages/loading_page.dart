import 'dart:ffi';

import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/user_page.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context1) {
    final height = MediaQuery.of(context1).size.width;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: checkLoginState(context1),
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.only(top: height * 0.7),
              child: Center(
                child: Column(
                  children: [
                    Text('Espere....'),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final socketServer = Provider.of<SocketService>(context, listen: false);
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final auth = await authServices.isLoggedIn();
    if (auth) {
      // Conectar con el socket
      socketServer.connect();
      Navigator.popAndPushNamed(context, "user");
    } else {
      Navigator.popAndPushNamed(context, "login");
    }
  }
}
