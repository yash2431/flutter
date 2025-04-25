import 'dart:io';

void main(){
  stdout.write("Enter your weight in pound:");
  double w =double.parse(stdin.readLineSync()!);

  stdout.write("Enter your height in pound:");
  double h =double.parse(stdin.readLineSync()!);

  w = w * 0.45359237;
  h = h * 0.254;

  print("index is ${w/(h*h)}");
}