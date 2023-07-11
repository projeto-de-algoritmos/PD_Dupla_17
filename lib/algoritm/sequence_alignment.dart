import 'package:dartz/dartz.dart';

List<List<int>> sequenceAlignment(
    String seq1, String seq2, int mismatchCost, int gapCost) {
  int m = seq1.length;
  int n = seq2.length;

  List<List<int>> matrix =
      List.generate(m + 1, (_) => List<int>.filled(n + 1, 0));

  // Inicialização da primeira linha e primeira coluna da matriz com 0's
  for (int i = 0; i <= m; i++) {
    matrix[i][0] = i * gapCost;
  }

  for (int j = 0; j <= n; j++) {
    matrix[0][j] = j * gapCost;
  }

  // Preenchimento da matriz
  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      int mismatch = matrix[i - 1][j - 1] +
          (seq1[i - 1] == seq2[j - 1] ? 0 : mismatchCost);
      int gapOnX = matrix[i - 1][j] + gapCost;
      int gapOnY = matrix[i][j - 1] + gapCost;

      matrix[i][j] = [mismatch, gapOnX, gapOnY].reduce((a, b) => a < b ? a : b);
    }
  }

  return matrix;
}

Tuple4<int, int, String, String> findSolution(List<List<int>> matrix,
    String seq1, String seq2, int mismatchCost, int gapCost) {
  int m = seq1.length;
  int n = seq2.length;
  String alignedSeq1 = '';
  String alignedSeq2 = '';
  int i = m;
  int j = n;
  int substitutionCount = 0;
  int gapCount = 0;

  while (i > 0 && j > 0) {
    if (seq1[i - 1] == seq2[j - 1]) {
      alignedSeq1 = seq1[i - 1] + alignedSeq1;
      alignedSeq2 = seq2[j - 1] + alignedSeq2;
      i--;
      j--;
    } else if (matrix[i][j] == matrix[i - 1][j - 1] + mismatchCost) {
      alignedSeq1 = seq1[i - 1] + alignedSeq1;
      alignedSeq2 = seq2[j - 1] + alignedSeq2;
      i--;
      j--;
      substitutionCount++;
    } else if (matrix[i][j] == matrix[i - 1][j] + gapCost) {
      alignedSeq1 = seq1[i - 1] + alignedSeq1;
      alignedSeq2 = '-$alignedSeq2';
      i--;
      gapCount++;
    } else {
      alignedSeq1 = '-$alignedSeq1';
      alignedSeq2 = seq2[j - 1] + alignedSeq2;
      j--;
      gapCount++;
    }
  }

  while (i > 0) {
    alignedSeq1 = seq1[i - 1] + alignedSeq1;
    alignedSeq2 = '-$alignedSeq2';
    i--;
  }

  while (j > 0) {
    alignedSeq1 = '-$alignedSeq1';
    alignedSeq2 = seq2[j - 1] + alignedSeq2;
    j--;
  }

  return Tuple4<int, int, String, String>(
      substitutionCount, gapCount, alignedSeq1, alignedSeq2);
}
