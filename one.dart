import 'dart:io';
void main(){
  print("my name is yash");

  print("enter first number");
  int n1 = int.parse(stdin.readLineSync()!);
  print("enter second number");
  int n2 = int.parse(stdin.readLineSync()!);

  print("addition is :${n1+n2}");

  print("enter number in fahrenheit");
  int n = int.parse(stdin.readLineSync()!);
  print("the conversion from F to C is:${(n-32)*5/9}");

  print("enter marks of 8 subjects");
  int no1 = int.parse(stdin.readLineSync()!);
  int no2 = int.parse(stdin.readLineSync()!);
  int no3 = int.parse(stdin.readLineSync()!);
  int no4 = int.parse(stdin.readLineSync()!);
  int no5 = int.parse(stdin.readLineSync()!);
  int no6 = int.parse(stdin.readLineSync()!);
  int no7 = int.parse(stdin.readLineSync()!);
  int no8 = int.parse(stdin.readLineSync()!);
  print("the percentage is:${((no1+no2+no3+no4+no5+no6+no7+no8)/100)*100}%");

  print("Enter the number in meters");
  int a = int.parse(stdin.readLineSync()!);
  print("the value in feets is:${a* 3.28084}");

  print("enter the weight in kg");
  int w = int.parse(stdin.readLineSync()!);
  print("enter the height in m");
  int h = int.parse(stdin.readLineSync()!);
  print("the bmi is:${w/(h*h)}");
  print("the weight in pounds is:${w*2.2}");
  print("the height in inches is:${h*39.26}");
}