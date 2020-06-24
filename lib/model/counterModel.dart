import 'package:flutter/material.dart';

class counterModel with ChangeNotifier{
  int value = 0;
  void increment(){
    value+=1;
    notifyListeners();
  }
  void clear(){
    value=0;
    notifyListeners();
  }
  void decrement(){
    value-=1;
    notifyListeners();
  }
}