import 'package:app/algoritm/sequence_alignment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sequence alignment ...', () async {
    final matriz = sequenceAlignment('lula', 'luka', 3, 2);

    printMatriz(matriz);
    final tuple = findSolution(matriz, 'lula', 'luka', 3, 2);

    print(tuple.value3);
    print(tuple.value4);
  });
}

void printMatriz(List<List<int>> matriz) {
  for (int i = 0; i < matriz.length; i++) {
    print(matriz[i]);
  }
}
