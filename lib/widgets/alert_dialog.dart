import 'package:flutter/material.dart';

class AlertNoti extends StatelessWidget {
  final String subtitle;
  final String title;
  const AlertNoti({Key? key, required this.title, required this.subtitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.subtitle),
    );
  }
}
