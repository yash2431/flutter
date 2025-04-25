import 'package:first/forms/login.dart';
import 'package:flutter/material.dart';

class Navigate extends StatelessWidget {
        Navigate({super.key});

  bool _isImageVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Navigation demo")
      ),
      body: Form(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder:(context) {
                        return LoginForm();
                      }));
            }, child: Text("About Page")
            ),
            if(_isImageVisible)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/your_image.jpg',
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      )
      );
  }
}
