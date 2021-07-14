import 'package:flutter/material.dart';

class CustonInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyBoardtype;
  final bool isPasword;
  final bool isError;

  const CustonInput(
      {Key? key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      this.keyBoardtype = TextInputType.text,
      this.isPasword = false,
      this.isError = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, right: 20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        obscureText: this.isPasword,
        keyboardType: this.keyBoardtype,
        decoration: InputDecoration(
            suffixIcon: this.isError
                ? Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  )
                : null,
            prefixIcon: Icon(this.icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.placeholder),
      ),
    );
  }
}
