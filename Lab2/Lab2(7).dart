import 'dart:io';

void main(){
  // stdout.write("Enter your String here:");
  // String name=stdin.readLineSync()!;
  //
  // int len=name.length-1;
  // print(len);
  // int size=0;
  //
  // while(name[len]!=" "){
  //   size++;
  //   len--;
  // }
  // print("last word size is $size");

//   other pipe line methos

  stdout.write("Enter your String here:");
  String name=stdin.readLineSync()!;
  print(name.split(" ").last.length);
}