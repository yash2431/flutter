import 'dart:io';

void main(){
  stdout.write("Enter Fahrenheit number:");
  int f=int.parse(stdin.readLineSync()!);
  print("Celsius is ${((f-32)/(9/5))}");
}