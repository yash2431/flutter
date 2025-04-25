import 'dart:io';

double si(double p,double r,double t){
  return((p*r*t)/100);
}

void main(){
  double p = double.parse(stdin.readLineSync()!);
  double r = double.parse(stdin.readLineSync()!);
  double t = double.parse(stdin.readLineSync()!);

  double interest = si(p,r,t);

  print("the simple interest is:$interest");
}
