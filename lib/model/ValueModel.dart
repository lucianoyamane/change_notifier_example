import 'package:flutter/cupertino.dart';

class ValueModel extends ChangeNotifier {
  int _count = 0;
  int _price = 0;

  set price(int price) {
    _price = price;
    notifyListeners();
  }

  int get count => _count;
  int get price => _price;

  incrementCounter() {
    _count++;
    notifyListeners();
  }

  decrementCounter() {
    _count--;
    notifyListeners();
  }

  int get result {
    return _count * _price;
  }
}