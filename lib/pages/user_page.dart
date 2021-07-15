import 'package:chat_app/models/getUser_response.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/storage_service.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final storage = new StorageService();

  List usuarios = [];

  @override
  void initState() {
    super.initState();
    _setUser();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketService>(context, listen: true);
    User user = authService.user;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            user.name,
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.black54,
            ),
            onPressed: () async {
              await storage.deleteValue("token");
              socketService.disconect();
              Navigator.popAndPushNamed(context, "login");
            },
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 5),
                child: socketService.serverStatus == ServerStatus.Online
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.error_outline_outlined,
                        color: Colors.red,
                      ))
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _setUser,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.green,
            ),
            waterDropColor: Colors.black54,
          ),
          child: _ListViewPrivated(),
        ));
  }

  ListView _ListViewPrivated() {
    return ListView.separated(
        itemBuilder: (_, i) => _userListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _userListTile(User user) {
    return ListTile(
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.pushNamed(context, "chat");
      },
      title: Text(user.name),
      subtitle: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                color: user.online ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(100)),
          ),
          Text('${user.phoneNumber}'),
        ],
      ),
      leading: CircleAvatar(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: user.img != ""
                ? Image(
                    image: AssetImage(user.img),
                  )
                : Text(user.name.substring(0, 2))),
      ),
      // trailing: Container(
      //   width: 25,
      //   height: 25,
      //   child: user.msj > 0
      //       ? Center(
      //           child: Text(
      //           "12",
      //           style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      //         ))
      //       : null,
      //   decoration: BoxDecoration(
      //       color: user.msj > 0 ? Colors.green : null,
      //       borderRadius: BorderRadius.circular(100)),
      // ),
    );
  }

  _setUser() async {
    final userService = UserService();
    usuarios = await userService.getUser();

    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
