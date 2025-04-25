import 'dart:io';

void main(){
  print("Enter your number:");
  stdout.write("1:");
  int n1=int.parse(stdin.readLineSync()!);
  stdout.write("2:");
  int n2=int.parse(stdin.readLineSync()!);
  stdout.write("3:");
  int n3=int.parse(stdin.readLineSync()!);

  if(n1<n2){
    if(n2<n3){
      print("number $n3 is largest");
    }
    else{
      print("number $n2 is largest");
    }
  }else{
    if(n1<n3){
      print("number $n3 is largest");
    }
    else{
      print("number $n1 is largest");
    }
  }
}