
import 'dart:math';

double calculateBMI (int weight, int height){
  return (weight/pow(height/100,2).round());
}
