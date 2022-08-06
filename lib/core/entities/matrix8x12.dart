import 'dart:typed_data';

import 'package:flutter/material.dart';

/// store 2D array  12x8 blocs to paint the Invader ships
///* Every bloc represents with digit/int that will define bloc color
///* 0 = transparent
///* 1 = white
///* unknown =  red
class Matrix8x12 {
  static const int row = 8;
  static const int col = 12;

  final List<List<int>> data;

  /// bloc will be 12x8
  Matrix8x12()
      : data = List.generate(row, (index) => List.generate(col, (index) => 0));

  /// 12x8 filled by zero
  factory Matrix8x12.zero() => Matrix8x12();

  /// 12x8 filled by one
  Matrix8x12.one()
      : data = List.generate(row, (index) => List.generate(col, (index) => 1));

  /// Get color of the cell
  static Color blocColor(int cellDigit) {
    switch (cellDigit) {
      case 0:
        return Colors.cyanAccent.withOpacity(.2);
      case 1:
        return Colors.white;

      default:
        return Colors.red;
    }
  }

  // update specific cell
  void setEntry({required int row, required int col, required int v}) {
    assert((row >= 0) && (row < Matrix8x12.row));
    assert((col >= 0) && (col < Matrix8x12.col));
    data[row][col] = v;
  }

  void fillRow({
    required int rowIndex,
    required int startCellIndex,
    int endCellIndex = col,
    int value = 1,
  }) {
    // for (int i = startCellIndex; i < endCellIndex; i++) {
    //   setEntry(col: i, row: rowIndex, v: value);
    // }

    data[rowIndex].replaceRange(startCellIndex, endCellIndex,
        List.filled(endCellIndex - startCellIndex + 1, 1));
  }

  /// clear [rowNumber] and fill [cellIndexes] with [value]
  void clearRowAndSetCells(
      {required int rowNumber,
      required List<int> cellIndexes,
      required int value}) {
    data[rowNumber] = Int64List(col);

    for (final cell in cellIndexes) {
      data[rowNumber][cell] = value;
    }
  }
}
