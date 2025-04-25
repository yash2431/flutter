import 'dart:io';

void main(){

  print("1: addition");
  print("2: subtarction");
  print("3: multiplication");
  print("4: division");
  int c=int.parse(stdin.readLineSync()!);

  print("Enter your number:");
  stdout.write("1:");
  int n1=int.parse(stdin.readLineSync()!);
  stdout.write("2:");
  int n2=int.parse(stdin.readLineSync()!);

  stdout.write("Which mwthod you use:");
  print("1: if..else");
  print("2: switch");

  int n=int.parse(stdin.readLineSync()!);

  if(n==1){
    if(c==1){
      print(n1+n2);
    }
    else if(c==2){
      print(n1-n2);
    }
    else if(c==3){
      print(n1*n2);
    }
    else if(c==1){
      print(n1/n2);
    }
    else{
      print("Enter valid choice!");
    }
  }
  else if(n==2){
    switch(c){
      case 1:
        print(n1+n2);
      case 2:
        print(n1-n2);
      case 3:
        print(n1*n2);
      case 4:
        print(n1/n2);
    }
  }
  else{
    if(c==1){
      print(n1+n2);
    }
    else if(c==2){
      print(n1-n2);
    }
    else if(c==3){
      print(n1*n2);
    }
    else if(c==1){
      print(n1/n2);
    }
    else{
      print("Enter valid choice!");
    }
  }



}