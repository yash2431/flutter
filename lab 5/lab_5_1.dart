import 'dart:io';

void main(){
  List<int> numbers = [0,0,0,0,0];

  print("Enter 5 numbers in a list:");
  for(var i in Iterable.generate(5)){
    print("Enter the numbers:");
    numbers[i] = int.parse(stdin.readLineSync()!);
  }
  numbers.sort();
  print(numbers);
}