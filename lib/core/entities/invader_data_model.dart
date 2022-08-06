import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/// store 2D array  12x8 blocs to paint the Invader ships
///* Every bloc represents with digit/int that will define bloc color
///* 0 = transparent
///* 1 = white
///* unknown =  red
class InvaderMatrix {
  static const int row = 8;
  static const int col = 12;

  final List<List<int>> data;

  /// bloc will be 12x8
  InvaderMatrix({required this.data});

  /// 12x8 filled by zero
  InvaderMatrix.zero()
      : data = List.generate(row, (index) => List.generate(col, (index) => 0));

  /// 12x8 filled by one
  InvaderMatrix.one()
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
    assert((row >= 0) && (row < InvaderMatrix.row));
    assert((col >= 0) && (col < InvaderMatrix.col));
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
  void _clearRowAndSetCells(
      {required int rowNumber,
      required List<int> cellIndexes,
      required int value}) {
    data[rowNumber] = Int64List(col);

    for (final cell in cellIndexes) {
      data[rowNumber][cell] = value;
    }
  }

  /// Invader A ship on X state
  static InvaderMatrix get aX => InvaderMatrix.zero()
    ..fillRow(rowIndex: 0, startCellIndex: 4, endCellIndex: 7)
    ..fillRow(rowIndex: 1, startCellIndex: 1, endCellIndex: 10)
    ..fillRow(rowIndex: 2, startCellIndex: 0)
    ..fillRow(rowIndex: 3, startCellIndex: 0, endCellIndex: 2)
    ..fillRow(rowIndex: 3, startCellIndex: 5, endCellIndex: 6)
    ..fillRow(rowIndex: 3, startCellIndex: 9)
    ..fillRow(rowIndex: 4, startCellIndex: 0)
    ..fillRow(rowIndex: 5, startCellIndex: 3, endCellIndex: 3)
    ..fillRow(rowIndex: 5, startCellIndex: 6, endCellIndex: 7)
    ..fillRow(rowIndex: 5, startCellIndex: 3, endCellIndex: 3)
    ..fillRow(rowIndex: 6, startCellIndex: 2, endCellIndex: 3)
    ..fillRow(rowIndex: 6, startCellIndex: 5, endCellIndex: 6)
    ..fillRow(rowIndex: 6, startCellIndex: 8, endCellIndex: 9)
    ..fillRow(rowIndex: 7, startCellIndex: 0, endCellIndex: 1)
    ..fillRow(rowIndex: 7, startCellIndex: 10, endCellIndex: 11);

  /// Invader A ship on Y state
  static InvaderMatrix get aY => aX
    .._clearRowAndSetCells(
        rowNumber: 5, cellIndexes: [2, 3, 4, 7, 8, 9], value: 1)
    .._clearRowAndSetCells(
        rowNumber: 6, cellIndexes: [1, 2, 5, 6, 9, 10], value: 1)
    .._clearRowAndSetCells(rowNumber: 7, cellIndexes: [2, 3, 8, 9], value: 1);

  static void printData(InvaderMatrix invaderMatrix) {
    for (int i = 0; i < invaderMatrix.data.length; i++) {
      for (int j = 0; j < invaderMatrix.data[i].length; j++) {
        stdout.write(
          " ${invaderMatrix.data[i][j]} ",
        );
      }

      print("End");
    }
  }
}
