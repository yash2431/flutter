import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({super.key});

  @override
  State<ListViewDemo> createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.green,
            height: 25,
            width: 65,
            alignment: Alignment.center,
          ),
          Container(
            color: Colors.blue,
            height: 25,
            width: 65,
            alignment: Alignment.center,
          ),
          Container(
            color: Colors.orange,
            height: 25,
            width: 65,
            alignment: Alignment.center,
          ),
          Container(
            color: Colors.greenAccent,
            height: 25,
            width: 65,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
