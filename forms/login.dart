import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController email = TextEditingController();
  TextEditingController PhoneNo = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();

  bool _isImageVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Form")),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: email,
              validator: (value) {
                if (value!.isEmpty) {
                  return ('Enter a valid email');
                }
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                  return ('Enter valid email');
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: PhoneNo,
              validator: (value) {
                if (value!.isEmpty) {
                  return ('Enter phone number');
                }
                if (value.length != 10) {
                  return ('Enter phone number of 10 digits');
                }
                if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                  return ('Enter valid number');
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Phone No',
                labelText: 'Phone No',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    _isImageVisible = true;
                  });
                }
              },
              child: Text("SUBMIT"),
            ),
            if (_isImageVisible)
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
      ),
    );
  }
}
