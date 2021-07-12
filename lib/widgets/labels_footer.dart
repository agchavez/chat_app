import 'package:flutter/material.dart';

class LabeStartPages extends StatelessWidget {
  final String textLabel;
  final String textIntial;
  final String page;

  const LabeStartPages(
      {Key? key,
      required this.textIntial,
      required this.textLabel,
      required this.page})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            this.textIntial,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.page);
            },
            child: Text(
              this.textLabel,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
