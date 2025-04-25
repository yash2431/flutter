import 'dart:io';
void main(){
  stdout.write("Enter your number:");
  int number=int.parse(stdin.readLineSync()!);

  bool flag=false;

  while(flag!=true){
    for(int i=2;i<number;i++){
      if(number%i==0){
        if(i==2 || i==3 ||i==5){
          flag=true;
        }
      }
    }
    if(flag==true){
      print("number $number is ugly number");
    }
    else{
      print("number $number is not ugly number");
      flag=true;
    }
  }
}