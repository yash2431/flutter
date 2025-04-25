import 'package:flutter/material.dart';

class Listview extends StatefulWidget {
  const Listview({super.key});

  @override
  State<Listview> createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  List<String> listdemo = ["A", "B", "C", "D", "E"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listdemo.length,
        itemBuilder: (context, index) {
          return Container(
              height: 400,
              width: 200,
              decoration: BoxDecoration(border: Border.all()),
              child: Center(child: Text(listdemo[index])))
          ;
        },
      ),
    );
  }
}
