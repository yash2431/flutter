import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView/GridView Toggle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isGridView = false; // Toggle state to switch between ListView and GridView

  List<String> data = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView/GridView Toggle'),
        actions: [
          Switch(
            value: isGridView,
            onChanged: (value) {
              setState(() {
                isGridView = value;
              });
            },
          ),
        ],
      ),
      body: isGridView
          ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items in a row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                data[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      )
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueAccent,
            child: ListTile(
              title: Text(
                data[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
