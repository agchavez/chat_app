import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatelessWidget {
  final usuarios = [
    User(
        email: 'lizbeth@email.com',
        name: "Lizbeth Rivera",
        phone: "32762869",
        msj: 2,
        online: true,
        uid: "1"),
    User(
        email: 'agchavez@email.com',
        name: "Angel Chavez",
        phone: "31998850",
        msj: 0,
        online: false,
        uid: "3"),
    User(
        email: 'jose@email.com',
        name: "Jose Martin",
        phone: "31998850",
        msj: 5,
        online: true,
        uid: "2")
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Gabriel Chavez',
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
          actions: [
            Container(
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            )
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
      title: Text(user.name),
      subtitle: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                color: user.online ? Colors.green : null,
                borderRadius: BorderRadius.circular(100)),
          ),
          Text(user.phone),
        ],
      ),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 25,
        height: 25,
        child: user.msj > 0
            ? Center(
                child: Text(
                "12",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ))
            : null,
        decoration: BoxDecoration(
            color: user.msj > 0 ? Colors.green : null,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _setUser() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
