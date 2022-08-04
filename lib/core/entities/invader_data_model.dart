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

  final List<List<int>> data;

  /// bloc will be 12x8
  InvaderMatrix({required this.data});

  /// 12x8 filled by zero
  InvaderMatrix.zero()
      : data = List.generate(8, (index) => List.generate(12, (index) => 0));

  /// 12x8 filled by one
  InvaderMatrix.one()
      : data = List.generate(8, (index) => List.generate(12, (index) => 1));

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

  void fillRow({
    required int rowIndex,
    required int startCellIndex,
    int endCellIndex = _col - 1,
    int value = 1,
  }) {
    data[rowIndex].replaceRange(startCellIndex, endCellIndex,
        List.filled(endCellIndex - startCellIndex, value));
  }

  static InvaderMatrix get aX => InvaderMatrix.zero()
        ..fillRow(rowIndex: 0, startCellIndex: 4, endCellIndex: 7)
      // ..fillRow(rowIndex: 1, startCellIndex: 1, endCellIndex: 10)
      // ..fillRow(rowIndex: 2, startCellIndex: 0)
      // ..fillRow(rowIndex: 3, startCellIndex: 0, endCellIndex: 2)
      // ..fillRow(rowIndex: 3, startCellIndex: 5, endCellIndex: 6)
      // ..fillRow(rowIndex: 3, startCellIndex: 9)
      // ..fillRow(rowIndex: 4, startCellIndex: 0)
      // ..fillRow(rowIndex: 5, startCellIndex: 2, endCellIndex: 3)
      // ..fillRow(rowIndex: 5, startCellIndex: 5, endCellIndex: 6)
      // ..fillRow(rowIndex: 5, startCellIndex: 2, endCellIndex: 3)
      // ..fillRow(rowIndex: 6, startCellIndex: 2, endCellIndex: 3)
      // ..fillRow(rowIndex: 6, startCellIndex: 5, endCellIndex: 6)
      // ..fillRow(rowIndex: 6, startCellIndex: 8, endCellIndex: 9)
      // ..fillRow(rowIndex: 7, startCellIndex: 0, endCellIndex: 1)
      // ..fillRow(rowIndex: 7, startCellIndex: 10, endCellIndex: 11)

      ;

  @override
  String toString() {
    return super.toString();
  }
}
