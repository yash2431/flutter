class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Full Name is required";
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return "Enter a valid name (letters only)";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return "Mobile number is required";
    }
    if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
      return "Enter a valid 10-digit mobile number";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    if (!RegExp(r"(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])").hasMatch(value)) {
      return "Password must include an uppercase letter, a number, and a special character";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return "City is required";
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return "Enter a valid city name (letters only)";
    }
    return null;
  }

  static String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return "Date of Birth is required";
    }

    // Regex for DD/MM/YYYY format
    if (!RegExp(r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$").hasMatch(value)) {
      return "The Date of Birth must be in DD/MM/YYYY format";
    }

    // Parse the date from the input string
    List<String> dateParts = value.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    DateTime dob = DateTime(year, month, day);
    DateTime today = DateTime.now();
    int age = today.year - dob.year;

    // Check if the user is at least 18 years old
    if (dob.isAfter(today.subtract(Duration(days: 18 * 365)))) {
      return "You must be at least 18 years old to register.";
    }

    // Check if the user is no older than 80 years
    if (dob.isBefore(today.subtract(Duration(days: 80 * 365)))) {
      return "The maximum age allowed is 80 years.";
    }

    return null;
  }
}