import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_user.dart';
import 'user_model.dart';
import 'user_provider.dart';
import 'user_detail.dart';
import 'edit_user.dart';
import 'favourite_user.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String searchQuery = "";
  String sortBy = "Name"; // Default sorting option
  bool isAscending = true; // Sorting order (true = Ascending, false = Descending)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUsers(); // ✅ Ensure latest data
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Filter users based on the search query
    final filteredUsers = userProvider.users.where((user) {
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
        title: Text("User List"),
        backgroundColor: Colors.blueAccent,
        actions: [
          Icon(Icons.wifi, color: userProvider.isConnected ? Colors.green.shade900 : Colors.red),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteUsersScreen()));
            },
          ),
        ],
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

          IconButton(
            icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() {
                isAscending = !isAscending;
              });
            },
          ),

          // 📝 User List (Filtered Results)
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(
              child: Text(
                "No Users Found",
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
                      backgroundColor: Colors.deepPurple[100],
                      child: Icon(Icons.person, color: Colors.deepPurple),
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Favorite Icon
                        IconButton(
                          icon: Icon(
                            user.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: user.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () async {
                            await userProvider.toggleFavorite(user.id!);
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditUserScreen(user: user),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteDialog(context, userProvider, user);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsScreen(user: user),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );

          if (result == true) {
            setState(() {}); // ✅ Ensure UI refreshes when returning
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, UserProvider userProvider, UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await userProvider.deleteUser(user.id.toString());
                Navigator.of(context, rootNavigator: true).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User deleted successfully!")));
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
