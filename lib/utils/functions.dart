import 'dart:math';

double calculateBMI (int weight, int height){
  return double.parse((weight/pow(height/100,2)).toStringAsFixed(1));
}
