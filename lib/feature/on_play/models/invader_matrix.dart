import 'dart:io';

import '../../../core/entities/matrix8x12.dart';

/// Enemy ship A with two State
class InvaderMatrixA extends Matrix8x12 implements _InvaderMatrixState {
  /// Invader A ship on X state
  static Matrix8x12 get _x {
    return Matrix8x12.head()
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
  static Matrix8x12 get _y {
    return _x
      ..clearRowAndSetCells(
          rowNumber: 5, cellIndexes: [2, 3, 4, 7, 8, 9], value: 1)
      ..clearRowAndSetCells(
          rowNumber: 6, cellIndexes: [1, 2, 5, 6, 9, 10], value: 1)
      ..clearRowAndSetCells(rowNumber: 7, cellIndexes: [2, 3, 8, 9], value: 1);
  }

  @override
  xState() => _x;

  @override
  yState() => _y;
}

/// Enemy ship B with two State
class InvaderMatrixB extends Matrix8x12 implements _InvaderMatrixState {
  /// Invader A ship on X state
  static Matrix8x12 get _x {
    final model = Matrix8x12.head()
          ..clearRowAndSetCells(
              rowNumber: 0, cellIndexes: [3, 4, 5, 6, 7, 8], value: 1)
          ..fillRow(rowIndex: 4, startCellIndex: 4, endCellIndex: 7)
          ..clearRowAndSetCells(
              rowNumber: 5, cellIndexes: [1, 2, 4, 5, 6, 7, 9, 10], value: 1)
        // ..clearRowAndSetCells(rowNumber: 6, cellIndexes: [1, 2, 10, 11], value: 1)
        // ..clearRowAndSetCells(rowNumber: 6, cellIndexes: [0, 1, 10, 11], value: 1)
        // ..clearRowAndSetCells(rowNumber: 7, cellIndexes: [2, 3, 8, 9], value: 1)

        ;

    return model;
  }

  /// Invader A ship on Y state
  static Matrix8x12 get _y {
    return _x
          ..clearRowAndSetCells(rowNumber: 0, cellIndexes: [2, 9], value: 1)
          ..clearRowAndSetCells(
              rowNumber: 1, cellIndexes: [0, 3, 8, 11], value: 1)
        // ..clearRowAndSetCells(
        //     rowNumber: 5, cellIndexes: [2, 3, 4, 7, 8, 9], value: 1)
        // ..clearRowAndSetCells(
        //     rowNumber: 6, cellIndexes: [1, 2, 5, 6, 9, 10], value: 1)
        // ..clearRowAndSetCells(rowNumber: 7, cellIndexes: [2, 3, 8, 9], value: 1)

        ;
  }

  @override
  yState() => _y;

  @override
  xState() => _x;
}

abstract class _InvaderMatrixState {
  xState();
  yState();
}

///
void printData(Matrix8x12 invaderMatrix) {
  for (int i = 0; i < invaderMatrix.data.length; i++) {
    for (int j = 0; j < invaderMatrix.data[i].length; j++) {
      stdout.write(
        " ${invaderMatrix.data[i][j]} ",
      );
    }
  }
}
