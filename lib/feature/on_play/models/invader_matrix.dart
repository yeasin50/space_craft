import 'dart:io';

import '../../../core/entities/matrix8x12.dart';

/// Enemy ship A with two State
class InvaderMatrixA extends Matrix8x12 {
  InvaderMatrixA() : super();

  factory InvaderMatrixA.x() => _x;
  factory InvaderMatrixA.y() => _y;

  /// Invader A ship on X state
  static InvaderMatrixA get _x {
    return InvaderMatrixA()
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
  }

  /// Invader A ship on Y state
  static InvaderMatrixA get _y {
    return _x
      ..clearRowAndSetCells(
          rowNumber: 5, cellIndexes: [2, 3, 4, 7, 8, 9], value: 1)
      ..clearRowAndSetCells(
          rowNumber: 6, cellIndexes: [1, 2, 5, 6, 9, 10], value: 1)
      ..clearRowAndSetCells(rowNumber: 7, cellIndexes: [2, 3, 8, 9], value: 1);
  }

  static void printData(Matrix8x12 invaderMatrix) {
    for (int i = 0; i < invaderMatrix.data.length; i++) {
      for (int j = 0; j < invaderMatrix.data[i].length; j++) {
        stdout.write(
          " ${invaderMatrix.data[i][j]} ",
        );
      }
    }
  }
}
