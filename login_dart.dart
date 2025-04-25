import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'user_provider.dart';

class LoginScreen extends StatefulWidget {

  final String? profileImage; // Dynamic Image Property
  const LoginScreen({super.key, this.profileImage});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false; // For confirm password visibility
  bool _isSignUp = false;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _loadSavedImage();
    _checkLoginStatus(); // Check if the user is already logged in
  }

  // Function to check if the user is already logged in
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      });
    }
  }

  // Email validation function
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation function with regex
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // Regex for password validation
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*\(\)_\+\-=<>?]).{8,}$').hasMatch(value)) {
      return 'Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a digit, and a special character';
    }
    return null;
  }

  /// Load saved image from shared preferences
  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedImagePath = prefs.getString('profileImage');
    if (savedImagePath != null) {
      setState(() {
        _imageFile = File(savedImagePath);
      });
    }
  }

  /// Pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImage', pickedFile.path);
    }
  }

  Future<void> _handleAuthAction() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      if (_isSignUp) {
        // Extract username from email
        String email = emailController.text;
        await prefs.setString('email', email);
        await prefs.setString('password', passwordController.text);
        await prefs.setBool('isLoggedIn', true);
        if (_imageFile != null) {
          await prefs.setString('profileImagePath', _imageFile!.path);
        }// ✅ Auto-login after sign-up

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account Created Successfully')));

        // Navigate to Dashboard with username
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        // Check login credentials
        String? savedEmail = prefs.getString('email');
        String? savedPassword = prefs.getString('password');

        if (savedEmail == emailController.text && savedPassword == passwordController.text) {

          prefs.setBool('isLoggedIn', true); // ✅ Mark user as logged in

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
        }
      }
    }
  }  // Confirm Password validation
  String? validateConfirmPassword(String? value) {
    if (_isSignUp && value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _saveUserImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userImage', imagePath);
  }

  // Handle login or sign-up action



  // Custom input decoration style
  InputDecoration customInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      filled: true,
      fillColor: Colors.blue[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blueAccent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blueAccent),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(_isSignUp ? "Sign Up" : "Login"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.wifi, color: userProvider.isConnected ? Colors.green.shade900 : Colors.red),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                      child: _imageFile == null
                          ? Icon(Icons.camera_alt, color: Colors.grey.shade700, size: 30)
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: customInputDecoration("Email Address", Icons.email),
                          validator: validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          decoration: customInputDecoration("Password", Icons.lock).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                          validator: validatePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: customInputDecoration("Confirm Password", Icons.lock).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_isConfirmPasswordVisible,
                          validator: validateConfirmPassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _handleAuthAction,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            elevation: 5,
                          ),
                          child: Text(
                            _isSignUp ? "Create Account" : "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isSignUp = !_isSignUp;
                            });
                          },
                          child: Text(
                            _isSignUp ? "Already have an account? Login" : "Don't have an account? Sign Up",
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
