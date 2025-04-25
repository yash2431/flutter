import 'dart:io';
void main() {
  print("Enter a no.:");
  int c = int.parse(stdin.readLineSync()!);
  print("ENter a no:");
  int d = int.parse(stdin.readLineSync()!);
  for (int i = c; i <= d; i++) {
    if (i % 2 == 0 && i % 3 != 0) {
      print("this no. is divisible by:$i");
    }
  }

  print("ENter a no:");
  int a = int.parse(stdin.readLineSync()!);
  int fac = 1;
  for (int i = a; i >= 1; i--) {
    fac = fac * i;
  }
  print("Factorial of no. is:$fac");

  print("ENter a no.:");
  int p = int.parse(stdin.readLineSync()!);
  int flag = 0;
  if (p == 0 || p == 1) {
    flag = 1;
  }
  for (int i = 2; i <= p / 2; ++i) {
    if (p % i == 0) {
      flag = 1;
      break;
    }
  }
  if (flag == 0) {
    print("it is a valid no.");
  }
  else {
    print("it is a invalid no.");
  }


  print("Enter a number: ");
  int n = int.parse(stdin.readLineSync()!);
  int rev = 0;

  while (n != 0) {
    int rem = n % 10;
    rev = rev * 10 + rem;
    n = n ~/ 10;
  }

  print("Reversed number: $rev");

  print("ENter a string:");
  String original = (stdin.readLineSync()!);
  String reversed = "";
  for (int i = original.length - 1; i >= 0; i--) {
    reversed += original[i];
  }
  print("Original string: $original");
  print("Reversed string: $reversed");

  int e=0;
  int f=0;
  while(true){
    stdout.write("Enter a list of numbers:");
    int num = int.parse(stdin.readLineSync()!);
    if(num==0){
      break;
    }
    else if(num>=0 && num%2==0){
      e+=num;
    }
    else if(num<=0 && num%2!=0) {
      f += num;
    }
  }
  print("sum of positive even number is:$e");
  print("sum of negative odd number is:$f");
}


