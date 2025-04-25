import 'package:flutter/material.dart';

class ScreenDemo extends StatefulWidget {
  const ScreenDemo({super.key});

  @override
  State<ScreenDemo> createState() => _ScreenDemoState();
}

class _ScreenDemoState extends State<ScreenDemo> {

  List<String> items = ['a','b','c','d'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemCount: items.length,itemBuilder: (context, index) {
        return Container(
              color: Colors.green,
              height: 25,
              width: 65,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(child: Text(items[index]),),
        );
      },),
    );
  }
}
