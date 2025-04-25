import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // To format dates

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get current date from system
    DateTime currentDate = DateTime.now();

    // Format the date in different formats
    String formattedDate1 = DateFormat('dd/MM/yyyy').format(currentDate);
    String formattedDate2 = DateFormat('dd-MM-yyyy').format(currentDate);
    String formattedDate3 = DateFormat('dd-MMM-yyyy').format(currentDate);
    String formattedDate4 = DateFormat('dd-MM-yy').format(currentDate);
    String formattedDate5 = DateFormat('dd MMM, yyyy').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll and Date Formatting"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Formatted Dates:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("dd/MM/yyyy: $formattedDate1"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("dd-MM-yyyy: $formattedDate2"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("dd-MMM-yyyy: $formattedDate3"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("dd-MM-yy: $formattedDate4"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("dd MMM, yyyy: $formattedDate5"),
            ),
            // Add more content to make the scroll effect noticeable
            SizedBox(height: 1000), // This will make sure the screen is scrollable
          ],
        ),
      ),
    );
  }
}
