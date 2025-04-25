import 'dart:io';

void main(){
  stdout.write("Enter your first number:");
  int number1=int.parse(stdin.readLineSync()!);

  stdout.write("Enter your secound number:");
  int number2=int.parse(stdin.readLineSync()!);

  print("Total addition is ${number1+number2}");
}