import 'dart:io';

void main(){
  stdout.write("Enter total metres: ");
  int M=int.parse(stdin.readLineSync()!);

  print("TOtal feets is ${M*3.28084}");

}