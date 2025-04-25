import 'dart:io';
void fibonacci(int s) {
  int n1 = 0;
  int n2 = 1;
  stdout.write("The Fibonacci series of size $s: ");
  stdout.write("$n1, $n2");
  for (int i = 2; i < s; i++) {
    int result = n1 + n2;
    n1 = n2;
    n2 = result;
    stdout.write(', $result');
  }
  print("");
}

void main() {
  print("Enter the size of Fibonacci series:");
  int s = int.parse(stdin.readLineSync()!);
  if (s <= 0) {
    print("Please enter a positive integer.");
  } else if (s == 1) {
    print("The Fibonacci series: 0");
  } else if (s == 2) {
    print("The Fibonacci series: 0, 1");
  } else {
    fibonacci(s);
  }
}
