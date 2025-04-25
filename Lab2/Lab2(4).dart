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

  if(P<35){
    print("FAIL");
  }
  else{
    if(35<P && P<45){
      print("pass Class");
    }
    else if(45<P && P<60){
      print("secound class");
    }
    else if(60<P && P<70){
      print("first class");
    }
    else if(P>70){
      print("distinction class");
    }
    else{
      print("No caculate marks");
    }
  }
}