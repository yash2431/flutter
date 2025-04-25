import 'package:flutter/material.dart';
import 'package:matrimonyapp/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'login_dart.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // Access UserProvider

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade400, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo
              FadeTransition(
                opacity: _animation,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: Icon(Icons.favorite, size: 50, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              // Animated Text
              FadeTransition(
                opacity: _animation,
                child: Text(
                  "Matrimony App",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 20),

              //Optional: Add connectivity status (uncomment if desired)
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi, color: userProvider.isConnected ? Colors.green.shade900 : Colors.red),
                  SizedBox(width: 10),
                  Text(
                    userProvider.isConnected ? "Connected" : "Offline",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Loading Indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
