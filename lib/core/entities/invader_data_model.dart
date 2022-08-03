import 'dart:typed_data';

import 'package:flutter/material.dart';

/// store 2D array  12x8 blocs to paint the Invader ships
///* Every bloc represents with digit/int that will define bloc color
///* 0 = transparent
///* 1 = white
///* unknown =  red
class InvaderMatrix {
  static const int _row = 8;
  static const int _col = 12;

  final List<Int64List> data;

  /// bloc will be 12x8
  InvaderMatrix({required this.data});

  /// 12x8 filled by zero
  InvaderMatrix.zero() : data = List.generate(8, (index) => Int64List(12));

  InvaderMatrix copyWith({required List<Int64List> data}) =>
      InvaderMatrix(data: data);

  /// Get color of the cell
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

  // update specific cell
  void setEntry(int row, int col, int v) {
    assert((row >= 0) && (row < _row));
    assert((col >= 0) && (col < _col));

    data[row][col] = v;
  }

  
}
