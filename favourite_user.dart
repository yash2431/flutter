import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'user_model.dart';
import 'favourite_user_details.dart';
import 'database_helper.dart'; // Import DatabaseHelper

class FavoriteUsersScreen extends StatefulWidget {
  const FavoriteUsersScreen({super.key});

  @override
  _FavoriteUsersScreenState createState() => _FavoriteUsersScreenState();
}

class _FavoriteUsersScreenState extends State<FavoriteUsersScreen> {
  String searchQuery = "";
  String sortBy = "Name"; // Default sorting option
  bool isAscending = true; // Sorting order (true = Ascending, false = Descending)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadFavoriteUsers();
    });
  }

  // Load favorite users from SQLite database
  void _loadFavoriteUsers() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final favoriteUsers = await DatabaseHelper.instance.getFavoriteUsers(); // Fetch from DB
    // Map the result from DB to UserModel and then update the provider
    userProvider.setFavoriteUsers(
      favoriteUsers.map((userMap) => UserModel.fromMap(userMap)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final favoriteUsers = userProvider.favoriteUsers;

    // Filter users based on the search query
    final filteredUsers = favoriteUsers.where((user) {
      return user.fullName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.city.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.gender.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.hobbies.join(", ").toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.dob.contains(searchQuery) ||
          user.age.toString().contains(searchQuery) ||
          user.mobile.contains(searchQuery) ||
          user.email.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    // Apply sorting logic
    filteredUsers.sort((a, b) {
      int comparison = 0;
      if (sortBy == "Name") {
        comparison = a.fullName.compareTo(b.fullName);
      } else if (sortBy == "City") {
        comparison = a.city.compareTo(b.city);
      } else if (sortBy == "Age") {
        comparison = a.age.compareTo(b.age);
      }
      return isAscending ? comparison : -comparison;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Users"),
        backgroundColor: Colors.redAccent,
        actions: [Icon(Icons.wifi, color: userProvider.isConnected ? Colors.green.shade900 : Colors.red)],
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search by Name, City, Gender, Age, DOB, etc.",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          SizedBox(width: 10),

          // Sorting Dropdown
          DropdownButton<String>(
            value: sortBy,
            onChanged: (newValue) {
              setState(() {
                sortBy = newValue!;
              });
            },
            items: ["Name", "City", "Age"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text("Sort by $value"),
              );
            }).toList(),
          ),

          // Sort Order Button (Ascending/Descending)
          IconButton(
            icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() {
                isAscending = !isAscending;
              });
            },
          ),

          // 📝 Favorite User List (Filtered Results)
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(
              child: Text(
                "No Favourite Users",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red[100],
                      child: Icon(Icons.person, color: Colors.red),
                    ),
                    title: Text(user.fullName, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Age: ${user.age}"),
                        Text("City: ${user.city}"),
                        Text("DOB: ${user.dob}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        userProvider.toggleFavorite(user.id as int);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteUserDetailsScreen(user: user, isFavoriteScreen: true),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
