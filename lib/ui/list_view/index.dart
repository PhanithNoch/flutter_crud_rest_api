import 'package:flutter/material.dart';
import 'package:learn_flutter_basic/main.dart';


class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Example'),
      ),

      body: Container(
        child: ListView(
          children: [
            Container(
              width: 160,
            ),
          ],
        ),
      ),
    );
  }
}
