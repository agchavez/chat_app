import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/socket_service.dart';

import 'package:chat_app/routers/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "loading",
        routes: appRoutes,
      ),
    );
  }
}
