import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_model.dart';
import 'user_provider.dart';

class FavoriteUserDetailsScreen extends StatelessWidget {
  final UserModel user;

  const FavoriteUserDetailsScreen({super.key, required this.user, required bool isFavoriteScreen});

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite User Details"),
        backgroundColor: Colors.deepPurple,
        actions: [Icon(Icons.wifi, color: userProvider.isConnected ? Colors.green.shade900 : Colors.red)],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                      user.fullName[0].toUpperCase(),
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    user.fullName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700),
                  ),
                  Text("${user.age} years old", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  SizedBox(height: 20),
                  Divider(),
                  buildDetailRow(Icons.email, "Email", user.email),
                  buildDetailRow(Icons.phone, "Mobile", user.mobile),
                  buildDetailRow(Icons.cake, "Date of Birth", user.dob),
                  buildDetailRow(Icons.location_city, "City", user.city),
                  buildDetailRow(Icons.wc, "Gender", user.gender),
                  buildDetailRow(Icons.sports, "Hobbies", user.hobbies.join(", ")),
                  Divider(),
                  SizedBox(height: 20),

                  // ✅ Wrap Floating Button inside Consumer to track dynamic state
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      bool isFav = userProvider.favoriteUsers.any((favUser) => favUser.id == user.id);

                      return FloatingActionButton.extended(
                        onPressed: () async {
                          await userProvider.toggleFavorite(user.id as int);
                          Navigator.pop(context, true); // ✅ Ensure UI refreshes after pop
                        },
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                        label: Text(isFav ? "Unfavourite" : "Favourite"),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 22),
          SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Spacer(),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[800])),
        ],
      ),
    );
  }
}
