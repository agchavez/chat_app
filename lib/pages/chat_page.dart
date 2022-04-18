import 'dart:io';

import 'package:chat_app/models/menssage_response.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/storage_service.dart';
import 'package:chat_app/widgets/chat_menssage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = new FocusNode();
  bool _typing = false;

  late ChatService chatService;
  late SocketService socketService;
  late AuthServices authServices;
  List<ChatMenssage> _menssage = [];
  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.authServices = Provider.of<AuthServices>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    _loadMenssages(this.chatService.userTo.id);
    this
        .socketService
        .socket
        .on("menssage-personal", (data) => _setMenssage(data));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (ChatMenssage menssage in _menssage) {
      menssage.animatedCrtl.dispose();
    }
    this.socketService.socket.off('menssage-personal');

    super.dispose();
  }

  void _loadMenssages(String id) async {
    List<Mensaje> menssages = await this.chatService.getChats(id);
    print("here");
    final history = menssages.map((e) => new ChatMenssage(
        texto: e.menssage,
        uid: e.from,
        date: e.createdAt,
        animatedCrtl: new AnimationController(
            vsync: this, duration: new Duration(milliseconds: 500))
          ..forward()));

    setState(() {
      _menssage.insertAll(0, history);
    });
  }

  void _setMenssage(dynamic data) {
    ChatMenssage menssage = ChatMenssage(
      date: DateTime.parse(data["date"]),
      texto: data["menssage"],
      uid: data["from"],
      animatedCrtl: AnimationController(
          vsync: this, duration: Duration(microseconds: 200)),
    );
    setState(() {
      _menssage.insert(0, menssage);
    });
    print(_menssage);

    menssage.animatedCrtl.forward();
  }

  @override
  Widget build(BuildContext context) {
    User userTo = chatService.userTo;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.blue[400]),
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              margin: EdgeInsets.only(right: 55),
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 18,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: userTo.img != ""
                            ? Image(
                                image: NetworkImage(userTo.img),
                              )
                            : Text(userTo.name.substring(0, 2))),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    userTo.name,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => _menssage[i],
                itemCount: _menssage.length,
                reverse: true,
              )),
              Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (value) {
              setState(() {
                if (value.length > 0) {
                  _typing = true;
                } else {
                  _typing = false;
                }
              });
            },
            focusNode: _focusNode,
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
          )),
          Container(
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _typing
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    )
                  : Container(
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: _typing
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                        ),
                      ),
                    ))
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    final newMenssage = new ChatMenssage(
      texto: text,
      uid: authServices.user.id,
      date: new DateTime.now(),
      animatedCrtl: AnimationController(
          vsync: this, duration: Duration(milliseconds: 50)),
    );
    _menssage.insert(0, newMenssage);
    newMenssage.animatedCrtl.forward();

    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _typing = false;
    });

    this.socketService.emit('menssage-personal', {
      'from': this.authServices.user.id,
      'to': this.chatService.userTo.id,
      'menssage': text
    });
  }
}
