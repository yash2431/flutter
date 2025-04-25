import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonyapp/user_model.dart';
import 'package:matrimonyapp/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_us.dart';
import 'add_user.dart';
import 'api_screen.dart';
import 'database_helper.dart';
import 'user_list.dart';
import 'favourite_user.dart';
import 'login_dart.dart'; // Import the Login Screen

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final dbHelper = DatabaseHelper.instance;
  String username = "User";
  String email = "";
  String userImage = "";
  int totalUsers = 0;
  int maleCount = 0;
  int femaleCount = 0;
  bool isLoading = false;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data dynamically
    _fetchUserStats(); // Fetch user statistics
  }

  // Load Logged-in User Data (Dynamically)
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? "email@example.com";
      userImage = prefs.getString('profileImagePath') ?? ""; // Retrieve user image path
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Delete saved image
    String? savedImagePath = prefs.getString('profileImage');
    if (savedImagePath != null) {
      final imageFile = File(savedImagePath);
      if (await imageFile.exists()) {
        await imageFile.delete(); // Delete the file
      }
      await prefs.remove('profileImage'); // Remove path from SharedPreferences
    }

    // Navigate back to login screen
    await prefs.setBool('isLoggedIn', false); // Clear login status
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }


  // Fetch User Statistics from SQLite Database
  Future<void> _fetchUserStats() async {
    setState(() => isLoading = true);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      List<UserModel> users;
      if (userProvider.isConnected) {
        users = await _apiService.fetchUsers();
      } else {
        final userMaps = await DatabaseHelper.instance.getAllUsers();
        users = userMaps.map((userMap) => UserModel.fromMap(userMap)).toList();
      }
      setState(() {
        totalUsers = users.length;
        maleCount = users.where((user) => user.gender == 'Male').length;
        femaleCount = users.where((user) => user.gender == 'Female').length;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        totalUsers = 0;
        maleCount = 0;
        femaleCount = 0;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch user stats: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // Listen for connectivity changes

    return Scaffold(
      // Background with gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // Custom AppBar with Blur Effect
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/m2.jpg',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.wifi, color: userProvider.isConnected ? Colors.green.shade900 : Colors.red),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // **Enhanced User Info Container (Dynamic Name & Email)**
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple.shade400, Colors.blue.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: userImage.isNotEmpty
                              ? FileImage(File(userImage)) // If image exists, show it
                              : AssetImage('assets/images/default_avatar.png') as ImageProvider, // Default avatar
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, $username 👋",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                email,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Total Users: $totalUsers | 👨 $maleCount | 👩 $femaleCount",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // **Refresh Icon**
                        IconButton(
                          icon: isLoading
                              ? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                              : Icon(Icons.refresh, color: Colors.white),
                          onPressed: isLoading ? null : _fetchUserStats, // Disable when loading
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Dashboard Grid
                  Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.all(16),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildDashboardItem(
                          context,
                          "Add User",
                          Icons.person_add,
                          AddUserScreen(),
                          Colors.blue[300]!,
                        ),
                        _buildDashboardItem(
                          context,
                          "User List",
                          Icons.list,
                          UserListScreen(),
                          Colors.green[300]!,
                        ),
                        _buildDashboardItem(
                          context,
                          "Favourites",
                          Icons.favorite,
                          FavoriteUsersScreen(),
                          Colors.red[300]!,
                        ),
                        _buildDashboardItem(
                          context,
                          "About Us",
                          Icons.info,
                          AboutUsScreen(),
                          Colors.orange[300]!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Logout Button in Bottom Right Corner
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.redAccent,
                    onPressed: () => _showLogoutDialog(context),
                    icon: Icon(Icons.exit_to_app, color: Colors.white),
                    label: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Enhanced Dashboard Item with animation
  Widget _buildDashboardItem(BuildContext context, String title, IconData icon, Widget? screen, Color backgroundColor) {
    return GestureDetector(
      onTap: () {
        if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No", style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              await _logout();// ✅ Only log out, keep user data

              Navigator.pop(context); // Close dialog

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false, // Prevents navigating back to Dashboard
              );
            },
            child: Text("Yes", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}