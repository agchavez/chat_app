import 'dart:ffi';

import 'package:flutter/material.dart';

class ButtomBlue extends StatelessWidget {
  final Function makeFn;
  final String textButton;

  const ButtomBlue({Key? key, required this.makeFn, required this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(2.0),
          shadowColor: MaterialStateProperty.all(Colors.blue),
          shape: MaterialStateProperty.all(StadiumBorder()),
        ),
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(
              this.textButton,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
        onPressed: () {
          this.makeFn();
        });
  }
}
