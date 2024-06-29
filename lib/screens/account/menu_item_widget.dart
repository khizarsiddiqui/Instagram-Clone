import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final String content;

  MenuItemWidget({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              '$content',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
