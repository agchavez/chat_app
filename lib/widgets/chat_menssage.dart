import 'package:flutter/material.dart';

class ChatMenssage extends StatelessWidget {
  final String texto;
  final String uid;
  final DateTime date;
  final AnimationController animatedCrtl;

  const ChatMenssage(
      {Key? key,
      required this.animatedCrtl,
      required this.texto,
      required this.date,
      required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animatedCrtl,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(curve: Curves.easeOut, parent: animatedCrtl),
        child: Container(
          child: this.uid == '123' ? _myMenssage() : _noMyMenssage(),
        ),
      ),
    );
  }

  Widget _myMenssage() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                margin: EdgeInsets.only(bottom: 5, left: 50),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  this.texto,
                  style: TextStyle(fontSize: 15),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[400],
                )),
          ),
          Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 5),
              child: Text("${this.date.hour}:${this.date.minute}",
                  style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }

  Widget _noMyMenssage() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(bottom: 5, right: 50),
                padding: EdgeInsets.all(8.0),
                child: Text("${this.texto}", style: TextStyle(fontSize: 15)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                )),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text("${this.toString().substring(0, 10)}",
                  style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
