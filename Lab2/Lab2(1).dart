import 'dart:io';

void main(){
  stdout.write("Enter your number:");
  int n=int.parse(stdin.readLineSync()!);

  if(n<0){
    print("Nmber is negative");
  }
  else if(n==0){
    print("Number is zero");
  }
  else{
    print("Number is positive");
  }
}