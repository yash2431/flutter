import 'dart:io';
void main(){
  print("Enter a no:");
  int n = int.parse(stdin.readLineSync()!);
  if(n>=0){
    print("${n} the no is positive");
  }
  else{
    print("${n} the no is negative");
  }

  print("Enter first no:");
  int a = int.parse(stdin.readLineSync()!);
  print("Enter second no:");
  int b = int.parse(stdin.readLineSync()!);
  print("Enter a operator:");
  String c = stdin.readLineSync()!;
  if(c=='+'){
    print("addition is:${a+b}");
  }
  else if(c=='-'){
    print("subtraction is:${a-b}");
  }
  else if(c=='*'){
    print("multiplication is:${a*b}");
  }
  else{
    print("division is:${a/b}");
  }

  print("Enter first number:");
  int d = int.parse(stdin.readLineSync()!);
  print("Enter second number:");
  int e = int.parse(stdin.readLineSync()!);
  if(d>e){
    print("d is largest:${d}");
  }
  else if(d<e){
    print("e is largest:${e}");
  }
  else{
    print("both numbers are equal");
  }

  print("Enter first number:");
  int f = int.parse(stdin.readLineSync()!);
  print("Enter second number:");
  int g = int.parse(stdin.readLineSync()!);
  print("Enter third number:");
  int h = int.parse(stdin.readLineSync()!);
  if(f>g && f>h){
    print("d is largest:${f}");
  }
  else if(g>h && g>f){
    print("e is largest:${g}");
  }
  else if(h>f && h>g){
    print("h is largest:${h}");
  }
  else{
    print("all three numbers are equal");
  }

  print("enter marks of 5 subjects");
  int no1 = int.parse(stdin.readLineSync()!);
  int no2 = int.parse(stdin.readLineSync()!);
  int no3 = int.parse(stdin.readLineSync()!);
  int no4 = int.parse(stdin.readLineSync()!);
  int no5 = int.parse(stdin.readLineSync()!);
  double p =((no1+no2+no3+no4+no5)/80)*100;
  print("the percentage is:${p}");
  if(p<35){
    print("student failed");
  }
  else if(p<45 && p>35){
    print("student passed");
  }
  else if(p<60 && p>45){
    print("student holds second class");
  }
  else if(p<70 && p>60){
    print("student holds first class");
  }
  else{
    print("student with distinction");
  }
}