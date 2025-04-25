import 'package:flutter/material.dart';

class Output extends StatelessWidget {
  const Output({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Output 1"),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,

        ),
      ),
      body: Column(
        children: [
          Expanded(child: Row(
            children: [
              Expanded(child: Container(
                color: Colors.yellowAccent,
              )),
              Expanded(child: Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Expanded(flex: 2,child: Container(
                        color: Colors.tealAccent,
                      )),
                      Expanded(child: Container(
                        color: Colors.teal,
                      )),
                    ],
                  )),
                ],
              )),
              Expanded(child: Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Expanded(flex: 2,child: Container(
                        color: Colors.deepOrange,
                      )),
                      Expanded(child: Container(
                        color: Colors.lightGreen,
                      )),
                    ],
                  )),
                ],
              )),
            ],
          )),
          Expanded(child: Row(
            children: [
              Expanded(child: Container(
                color: Colors.white,
              )),
              Expanded(child: Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Expanded(child: Container(
                        color: Colors.deepPurple,
                      )),
                      Expanded(child: Container(
                        color: Colors.pinkAccent,
                      )),
                      Expanded(child: Container(
                        color: Colors.blue,
                      ))
                    ],
                  )),
                  Expanded(child: Column(
                    children: [
                      Expanded(child: Container(
                        color: Colors.amber,
                      )),
                      Expanded(child: Container(
                        color: Colors.greenAccent,
                      )),
                      Expanded(child: Container(
                        color: Colors.indigo,
                      ))
                    ],
                  )),
                  Expanded(child: Column(
                    children: [
                      Expanded(child: Container(
                        color: Colors.lightGreen,
                      )),
                      Expanded(child: Container(
                        color: Colors.blueGrey,
                      )),
                      Expanded(child: Container(
                        color: Colors.orangeAccent,
                      ))
                    ],
                  )),
                ],
              )),
              Expanded(child: Container(
                color: Colors.amber,
              )),
            ],
          )),
          Expanded(child: Row(
            children: [
              Expanded(child: Container(
                color: Colors.red,
              )),
              Expanded(child: Container(
                color: Colors.lightGreen,
              )),
              Expanded(child: Container(
                color: Colors.deepPurple,
              )),
            ],
          ))
        ],
      ),
    );
  }
}
