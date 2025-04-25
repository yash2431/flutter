import 'dart:io';

void max(double a,double b){
  if(a>b){
    print("max number is:$a");
  }
  else if(a==b){
    print("both number are equal");
  }
  else{
    print("max number is:$b");
  }
}

void main(){
  print("Enter a no. a:");
  double a = double.parse(stdin.readLineSync()!);
  print("Enter a no. b:");
  double b = double.parse(stdin.readLineSync()!);
  max(a,b);
}
