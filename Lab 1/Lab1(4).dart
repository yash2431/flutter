import 'dart:io';

void main(){
  print("Write all the mark out of 100");

  stdout.write("Enter WT mark :");
  int m1=int.parse(stdin.readLineSync()!);

  stdout.write("Enter maths mark :");
  int m2=int.parse(stdin.readLineSync()!);

  stdout.write("Enter python mark :");
  int m3=int.parse(stdin.readLineSync()!);

  stdout.write("Enter flutter mark :");
  int m4=int.parse(stdin.readLineSync()!);

  stdout.write("Enter OAT mark :");
  int m5=int.parse(stdin.readLineSync()!);

  int sum=m1+m2+m3+m4+m5;

  print("500/$sum");

  print("Percentage is ${(sum*100)/500}");
  double P=(sum*100)/500;

  if(P<33){
    print("FAIL");
  }
  else{
    print("PASS");
  }


}