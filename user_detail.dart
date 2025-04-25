import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'user_model.dart';
import 'user_provider.dart';
import 'edit_user.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserModel user;
  final bool isFavoriteScreen;

  const UserDetailsScreen({super.key, required this.user,this.isFavoriteScreen = false});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {

  Future<File> generateUserPDF(UserModel user) async {
    final pdf = pw.Document();

    // ✅ Load custom font (Roboto)
    final font = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto/static/Roboto-Regular.ttf"));
    final boldFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto/static/Roboto-Bold.ttf"));

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("User Details", style: pw.TextStyle(font: boldFont, fontSize: 24)),
              pw.SizedBox(height: 10),
              pw.Text("Name: ${user.fullName}", style: pw.TextStyle(font: font)),
              pw.Text("Age: ${user.age}", style: pw.TextStyle(font: font)),
              pw.Text("Email: ${user.email}", style: pw.TextStyle(font: font)),
              pw.Text("Mobile: ${user.mobile}", style: pw.TextStyle(font: font)),
              pw.Text("City: ${user.city}", style: pw.TextStyle(font: font)),
              pw.Text("Gender: ${user.gender}", style: pw.TextStyle(font: font)),
              pw.Text("Hobbies: ${user.hobbies.join(", ")}", style: pw.TextStyle(font: font)),
            ],
          ),
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/UserDetails_${user.fullName}.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  void sharePDF(File file) {
    Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/pdf')],
        text: "Here is the user details PDF!"
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "User Details", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [Icon(Icons.wifi, color: userProvider.isConnected ? Colors.green.shade900 : Colors.red)],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade100, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.deepPurple[100],
                                child: Text(
                                  widget.user.fullName.isNotEmpty ? widget.user
                                      .fullName[0].toUpperCase() : "?",
                                  style: TextStyle(fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                widget.user.fullName,
                                style: TextStyle(fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple.shade700),
                              ),
                              Text(
                                "${widget.user.age} years old",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600]),
                              ),
                              SizedBox(height: 20),
                              Divider(thickness: 1),
                              buildDetailRow(
                                  Icons.email, "Email", widget.user.email),
                              buildDetailRow(
                                  Icons.phone, "Mobile", widget.user.mobile),
                              buildDetailRow(
                                  Icons.cake, "Date of Birth", widget.user.dob),
                              buildDetailRow(Icons.location_city, "City",
                                  widget.user.city),
                              buildDetailRow(
                                  Icons.wc, "Gender", widget.user.gender),
                              buildDetailRow(Icons.sports, "Hobbies",
                                  widget.user.hobbies.join(", ")),
                              Divider(thickness: 1),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      userProvider.favoriteUsers.contains(
                                          widget.user) ? Icons.favorite : Icons
                                          .favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await userProvider.toggleFavorite(
                                          widget.user.id!);
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Text(
                                    "Favourite",
                                    style: TextStyle(fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  FloatingActionButton.extended(
                                    heroTag: "editBtn",
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditUserScreen(user: widget.user),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                    label: Text("Edit"),
                                  ),
                                  FloatingActionButton.extended(
                                    heroTag: "deleteBtn",
                                    onPressed: () {
                                      _showDeleteDialog(
                                          context, userProvider, widget.user);
                                    },
                                    icon: Icon(Icons.delete),
                                    label: Text("Delete"),
                                  ),
                                  FloatingActionButton.extended(
                                    onPressed: () async {
                                      File pdfFile = await generateUserPDF(widget.user); // Generate the PDF
                                      sharePDF(pdfFile); // Call the function to share
                                    },
                                    icon: Icon(Icons.share),
                                    label: Text("Share"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Helper function to create a row with an icon for each detail
  Widget buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 22),
          SizedBox(width: 10),
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Spacer(),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[800])),
        ],
      ),
    );
  }

  // Function to show delete confirmation dialog
  void _showDeleteDialog(BuildContext context, UserProvider userProvider,
      UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await userProvider.deleteUser(user.id.toString());
                Navigator.of(context, rootNavigator: true).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User deleted successfully!")));
                Navigator.pop(context);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
