class UserModel {
  int? id; // ✅ Change to int? (nullable, since SQLite assigns it)
  String fullName;
  String email;
  String mobile;
  String dob;
  int age;
  String city;
  String gender;
  List<String> hobbies;
  String password;
  bool isFavorite;

  UserModel({
    this.id, // ✅ Now nullable
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.age,
    required this.city,
    required this.gender,
    required this.hobbies,
    required this.password,
    this.isFavorite = false,
  });

  // ✅ Convert UserModel to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // SQLite will auto-generate if null
      'name': fullName,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'age': age,
      'city': city,
      'gender': gender,
      'hobbies': hobbies.join(','),
      'password': password,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }


  // ✅ Convert Map from SQLite back to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? int.parse(map['id'].toString()) : null, // ✅ Ensure id is assigned correctly
      fullName: map['name'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      dob: map['dob'] ?? '',
      age: map['age'] != null ? int.parse(map['age'].toString()) : 0,
      city: map['city'] ?? '',
      gender: map['gender'] ?? '',
      hobbies: (map['hobbies'] ?? '').split(','),
      password: map['password'] ?? '',
      isFavorite: map['isFavorite'] == 1 || map['isFavorite'] == true,
    );
  }
}
