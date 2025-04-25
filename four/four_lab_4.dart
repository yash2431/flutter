import 'dart:io';

int check(int n) {
  if (n <= 1) {
    return 0;
  }
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) {
      return 0;
    }
  }
  return 1;
}
void main() {
  print("Enter a number:");
  int n = int.parse(stdin.readLineSync()!);
  int result = check(n);
  if (result == 1) {
    print("$n is a prime number.");
  } else {
    print("$n is not a prime number.");
  }
}
