import 'dart:io';

void countEvenOdd(List<int> numbers) {
  int evenCount = 0;
  int oddCount = 0;
  for (int num in numbers) {
    if (num % 2 == 0) {
      evenCount++;
    } else {
      oddCount++;
    }
  }
  print("Number of even numbers: $evenCount");
  print("Number of odd numbers: $oddCount");
}

void main() {
  print("Enter the number of elements in the array:");
  int n = int.parse(stdin.readLineSync()!);
  List<int> numbers = [];
  print("Enter the elements of the array:");
  for (int i = 0; i < n; i++) {
    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }
  countEvenOdd(numbers);
}
