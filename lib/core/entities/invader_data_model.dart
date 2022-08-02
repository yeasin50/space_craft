import 'package:flutter/material.dart';

/// store 2D array  12x8 blocs to paint the Invader ships
///* Every bloc represents with digit/int that will define bloc color
///* 0 = transparent
///* 1 = white
///* unknown =  red
class InvaderDataModel {
  final List<List<int>> bloc;

  InvaderDataModel({
    List<List<int>>? data,
  }) : bloc = data ?? List.filled(12, List.generate(8, (index) => 3));

  InvaderDataModel copyWith({
    List<List<int>>? data,
  }) {
    return InvaderDataModel(
      data: data ?? bloc,
    );
  }
}

class InvaderData extends InvaderDataModel {
  static Color blocColor(int cellDigit) {
    switch (cellDigit) {
      case 0:
        return Colors.transparent;
      case 1:
        return Colors.white;

      default:
        return Colors.red;
    }
  }

  factory InvaderData.invaderAA() {
    
  }
}
