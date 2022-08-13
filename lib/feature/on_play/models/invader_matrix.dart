import 'dart:io';

import '../../../core/entities/matrix8x12.dart';

abstract class _InvaderMatrixState {
  get xState;
  get yState;
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
          rowIndex: 5, cellIndexes: [2, 3, 4, 7, 8, 9], value: 1)
      ..clearRowAndSetCells(
          rowIndex: 6, cellIndexes: [1, 2, 5, 6, 9, 10], value: 1)
      ..clearRowAndSetCells(rowIndex: 7, cellIndexes: [2, 3, 8, 9], value: 1);
  }

  @override
  get xState => _x;

  @override
  get yState => _y;
}

/// Enemy ship B with two State
class InvaderMatrixB extends Matrix8x12 implements _InvaderMatrixState {
  /// Invader B ship on X state
  static Matrix8x12 get _x {
    return Matrix8x12.head()
          ..clearRowAndSetCells(rowIndex: 0, cellIndexes: [2, 9], value: 1)
          ..clearRowAndSetCells(rowIndex: 1, cellIndexes: [3, 8], value: 1)
          ..fillRow(rowIndex: 2, value: 0)
          ..fillRow(rowIndex: 2, startCellIndex: 2, endCellIndex: 9)
          ..clearRowAndSetCells(
              rowIndex: 3, cellIndexes: [1, 2, 4, 5, 6, 7, 9, 10], value: 1)
          ..fillRow(rowIndex: 4)
          ..fillRow(rowIndex: 5)
          ..setEntry(row: 5, col: 1, v: 0)
          ..setEntry(row: 5, col: 10, v: 0)
          ..clearRowAndSetCells(
              rowIndex: 6, cellIndexes: [0, 2, 9, 11], value: 1)
          ..clearRowAndSetCells(
              rowIndex: 7, cellIndexes: [3, 4, 7, 8], value: 1)
        //
        ;
  }

  /// Invader B ship on Y state
  static Matrix8x12 get _y {
    return _x
      ..clearRowAndSetCells(rowIndex: 0, cellIndexes: [2, 9], value: 1)
      ..clearRowAndSetCells(rowIndex: 1, cellIndexes: [0, 3, 8, 11], value: 1)
      ..setEntry(row: 2, col: 0, v: 1)
      ..setEntry(row: 3, col: 0, v: 1)
      ..setEntry(row: 2, col: 11, v: 1)
      ..setEntry(row: 3, col: 11, v: 1)
      ..fillRow(rowIndex: 5, value: 0)
      ..fillRow(rowIndex: 5, startCellIndex: 1, endCellIndex: 10, value: 1)
      ..clearRowAndSetCells(rowIndex: 6, cellIndexes: [2, 9], value: 1)
      ..clearRowAndSetCells(rowIndex: 7, cellIndexes: [1, 10], value: 1);
  }

  @override
  get yState => _y;

  @override
  get xState => _x;
}

///Enemy ship C with two State
class InvaderMatrixC extends Matrix8x12 implements _InvaderMatrixState {
  /// Invader B sh ip on X state
  static Matrix8x12 get _x {
    final model = Matrix8x12.head()
      ..clearRowAndSetCells(
          rowIndex: 0, cellIndexes: [3, 4, 5, 6, 7, 8], value: 1)
      ..setEntry(row: 3, col: 4, v: 1)
      ..setEntry(row: 3, col: 7, v: 1)
      ..clearRowAndSetCells(
          rowIndex: 5, cellIndexes: [1, 2, 4, 5, 6, 7, 9, 10], value: 1)
      ..clearRowAndSetCells(rowIndex: 6, cellIndexes: [1, 2, 10, 11], value: 1)
      ..clearRowAndSetCells(rowIndex: 6, cellIndexes: [0, 1, 10, 11], value: 1)
      ..clearRowAndSetCells(rowIndex: 7, cellIndexes: [2, 3, 8, 9], value: 1);

    return model;
  }

  /// Invader B ship on Y state
  static Matrix8x12 get _y {
    return _x
      ..clearRowAndSetCells(rowIndex: 0, cellIndexes: [2, 9], value: 1)
      ..clearRowAndSetCells(rowIndex: 1, cellIndexes: [0, 3, 8, 11], value: 1)
      ..fillRow(rowIndex: 5, value: 0)
      ..fillRow(rowIndex: 5, startCellIndex: 1, endCellIndex: 10, value: 1)
      ..clearRowAndSetCells(rowIndex: 6, cellIndexes: [2, 9], value: 1)
      ..clearRowAndSetCells(rowIndex: 7, cellIndexes: [1, 10], value: 1);
  }

  @override
  get yState => _y;

  @override
  get xState => _x;
}
