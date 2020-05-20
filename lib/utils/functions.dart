
import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';

double calculateBMI (int weight, int height){
  return double.parse((weight/pow(height/100,2)).toStringAsFixed(1));
}

/*Color challengeColor(){
  if(challenges[index]['difficult'] = 3){
    return Colors.blue;
  }

}*/