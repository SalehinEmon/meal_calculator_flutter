import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meal_calculator/model/mess_member_model.dart';

class MessCalculatorProvider extends ChangeNotifier {
  List<MessMemberModel> _allMember = [];
  int get length => _allMember.length;
  List<MessMemberModel> get allMember => _allMember;
  bool waitFlag = true;
  final LocalStorage storage = LocalStorage('member_list.json');

  MessCalculatorProvider() {
    if (kDebugMode) {
      print('constructor called');
    }

    _loadData();
  }
  _loadData() async {
    waitFlag = true;
    await storage.ready;
    String memberListString = storage.getItem('member_list') ?? '';

    if (memberListString.isNotEmpty) {
      _allMember = (jsonDecode(memberListString) as List)
          .map((member) => MessMemberModel.fromJson(member))
          .toList();
    }

    waitFlag = false;
    notifyListeners();
  }

  add(MessMemberModel member) {
    _allMember.add(member);
    reloadToLocalStoreage();
    notifyListeners();
  }

  reloadToLocalStoreage() async {
    await storage.ready;
    storage.setItem('member_list', jsonEncode(_allMember));
  }

  removeAll() {
    _allMember.clear();
    reloadToLocalStoreage();
    notifyListeners();
  }

  removeAt(int index) {
    if (index < length) {
      _allMember.removeAt(index);
    }
    reloadToLocalStoreage();
    notifyListeners();
  }

  updateAt(int index, MessMemberModel member) {
    if (index < length) {
      _allMember[index] = member;
    }
    reloadToLocalStoreage();
    notifyListeners();
  }

  double totalMeal() {
    double totalMeal = 0;
    for (var member in _allMember) {
      totalMeal += member.totalMeal ?? 0;
    }
    return totalMeal;
  }

  double totalExpense() {
    double totalExpense = 0;

    for (var member in _allMember) {
      totalExpense += member.totalExpense ?? 0;
    }

    return totalExpense;
  }

  double perMealCost() {
    double totalMealCount = totalMeal();
    double totalExpenseCount = totalExpense();

    if (totalMealCount != 0) {
      return totalExpenseCount / totalMealCount;
    }
    return 0;
  }

  double totalMealCost() {
    double totalMealCost = 0;
    for (var member in _allMember) {
      totalMealCost += (member.totalMeal ?? 0) * perMealCost();
    }

    return totalMealCost;
  }
}
