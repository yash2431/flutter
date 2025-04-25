import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'user_model.dart';
import 'user_provider.dart';
import 'validators.dart';
import 'package:flutter/services.dart';

class EditUserScreen extends StatefulWidget {
  final UserModel user;

  const EditUserScreen({super.key, required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController _dobController;
  late TextEditingController cityController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String gender = "Male";
  List<String> selectedHobbies = [];

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.user.fullName);
    emailController = TextEditingController(text: widget.user.email);
    mobileController = TextEditingController(text: widget.user.mobile);
    _dobController = TextEditingController(text: widget.user.dob);
    cityController = TextEditingController(text: widget.user.city);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    gender = widget.user.gender;
    selectedHobbies = List.from(widget.user.hobbies);
  }

  int _calculateAge(String dobString) {
    List<String> dobParts = dobString.split('/');
    int day = int.parse(dobParts[0]);
    int month = int.parse(dobParts[1]);
    int year = int.parse(dobParts[2]);

    DateTime dob = DateTime(year, month, day);
    DateTime today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        _dobController.text = formattedDate;
      });
    }
  }

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
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        actions: [Icon(Icons.wifi, color: userProvider.isConnected ? Colors.green.shade900 : Colors.red)],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: customInputDecoration("Full Name", Icons.person),
                validator: Validators.validateName,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: emailController,
                decoration: customInputDecoration("Email Address", Icons.email),
                validator: Validators.validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: mobileController,
                decoration: customInputDecoration("Mobile Number", Icons.phone),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile number is required';
                  }
                  if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _dobController,
                decoration: customInputDecoration("Date of Birth", Icons.calendar_today).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.blueAccent),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) {
                  String? dobError = Validators.validateDOB(value);
                  if (dobError != null) return dobError;
                  int age = _calculateAge(value!);
                  if (age < 18) return "Must be at least 18 years old.";
                  if (age > 80) return "Max age is 80 years.";
                  return null;
                },
                readOnly: true,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: cityController,
                decoration: customInputDecoration("City", Icons.location_city),
                validator: Validators.validateCity,
              ),
              SizedBox(height: 10),

              Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Radio(
                    value: "Male",
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value.toString()),
                  ),
                  Text("Male"),
                  Radio(
                    value: "Female",
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value.toString()),
                  ),
                  Text("Female"),
                  Radio(
                    value: "Other",
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value.toString()),
                  ),
                  Text("Other"),
                ],
              ),
              SizedBox(height: 10),

              Text("Hobbies", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Wrap(
                children: ["Reading", "Traveling", "Music"].map((hobby) {
                  return CheckboxListTile(
                    title: Text(hobby),
                    value: selectedHobbies.contains(hobby),
                    onChanged: (value) {
                      setState(() {
                        value! ? selectedHobbies.add(hobby) : selectedHobbies.remove(hobby);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 10),



            TextFormField(
              controller: passwordController,
              decoration: customInputDecoration("Password", Icons.lock).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
              validator: Validators.validatePassword,
            ),
            SizedBox(height: 10),

            TextFormField(
              controller: confirmPasswordController,
              decoration: customInputDecoration("Confirm Password", Icons.lock).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isConfirmPasswordVisible,
              validator: (value) => Validators.validateConfirmPassword(value, passwordController.text),
            ),


              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    int age = _calculateAge(_dobController.text);
                    UserModel updatedUser = UserModel(
                      id: widget.user.id,
                      fullName: fullNameController.text,
                      email: emailController.text,
                      mobile: mobileController.text,
                      dob: _dobController.text,
                      age: age,
                      city: cityController.text,
                      gender: gender,
                      hobbies: selectedHobbies,
                      password: passwordController.text.isEmpty ? widget.user.password : passwordController.text,
                    );

                    await userProvider.editUser(widget.user.id.toString(), updatedUser);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User updated successfully!"), backgroundColor: Colors.green));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.save, color: Colors.white),
                label: Text("Save Changes", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
