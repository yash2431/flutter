import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Darshan University Logo Section
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.deepPurple,
              child: Column(
                children: [
                  Image.asset('assets/images/Screenshot 2025-02-09 182046.png', height: 100),
                  SizedBox(height: 10),
                  Text(
                    "ASWDC - Darshan University",
                    style: TextStyle(color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Empowering students with cutting-edge technology & real-world applications.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Meet Our Team Section
            _buildCard(
              title: "Meet Our Team",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTeamRow("Developed by", "Yash Pipalava (23010101208)"),
                  _buildTeamRow("Mentored by",
                      "Prof. Mehul Bhundiya (Computer Engineering)"),
                  _buildTeamRow(
                      "Explored by", "ASWDC, School Of Computer Science"),
                  _buildTeamRow("Eulogized by",
                      "Darshan University, Rajkot, Gujarat - INDIA"),
                ],
              ),
            ),

            // About ASWDC Section
            _buildCard(
              title: "About ASWDC",
              content: Column(
                children: [
                  Image.asset('assets/images/Screenshot 2025-02-09 180821.png', height: 80),
                  SizedBox(height: 10),
                  Text(
                    "ASWDC is an Application, Software, and Website Development Center at Darshan University, run by students & faculty members of the School of Computer Science.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Description Section
            _buildCard(
              title: "Our Vision",
              content: Text(
                "The sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real-world applications, and gain professional experience under expert guidance.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            // Contact Us Section
            _buildCard(
              title: "Contact Us",
              content: Column(
                children: [
                  _buildContactRow(Icons.email, "aswdc@darshan.ac.in"),
                  _buildContactRow(Icons.phone, "+91-9727747317"),
                  _buildContactRow(Icons.web, "www.darshan.ac.in"),
                ],
              ),
            ),

            // Extra Options (Share App, More Apps, etc.)
            _buildCard(
              title: "More Options",
              content: Column(
                children: [
                  _buildOptionRow(Icons.share, "Share App"),
                  _buildOptionRow(Icons.apps, "More App"),
                  _buildOptionRow(Icons.star, "Rate Us"),
                  _buildOptionRow(Icons.thumb_up, "Like us on Facebook"),
                  _buildOptionRow(Icons.update, "Check For Update"),
                ],
              ),
            ),

            // Footer Section
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Divider(),
                  Text(
                    "© 2025 Darshan University",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    "All Rights Reserved - Privacy Policy",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Made with ❤️ in India",
                    style: TextStyle(fontSize: 14, color: Colors.redAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a styled Card
  Widget _buildCard({required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              Divider(),
              content,
            ],
          ),
        ),
      ),
    );
  }

  // Function to create a row for Meet Our Team section
  Widget _buildTeamRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build Contact Us row with icon
  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 22),
          SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // Function to build options row with icon and action
  Widget _buildOptionRow(IconData icon, String text) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple, size: 22),
            SizedBox(width: 10),
            Text(text, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
