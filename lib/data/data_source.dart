import 'package:app/algoritm/sequence_alignment.dart';
import 'package:app/data/data.dart';
import 'package:app/politician_option.dart';
import 'package:app/utils/failure.dart';
import 'package:dartz/dartz.dart';

class BetterMatch {
  PoliticianOption politicianOption;
  int substitutionCount;
  int gapCount;
  String string1;
  String string2;

  BetterMatch(
    this.politicianOption,
    this.substitutionCount,
    this.gapCount,
    this.string1,
    this.string2,
  );
  @override
  String toString() {
    return 'politicianOption: $politicianOption, substitutionCount: $substitutionCount, gapCount: $gapCount, string1: $string1, string2: $string2';
  }
}

class DataSource {
  Either<Failure, PoliticianOption> getPoliticianOption(String insertedText) {
    List<String> textedWords = insertedText.split(' ');
    BetterMatch? betterMatch;
    List<BetterMatch> betterMatches = [];

    for (String word in textedWords) {
      for (String politicianWord in palavrasDireita) {
        final matriz = sequenceAlignment(word, politicianWord, 3, 2);
        final tuple = findSolution(matriz, word, politicianWord, 3, 2);
        //Compare Substitution count
        if (betterMatch == null ||
            tuple.value1 + tuple.value2 <
                betterMatch.substitutionCount + betterMatch.gapCount) {
          betterMatch = BetterMatch(
            PoliticianOption.direita,
            tuple.value1,
            tuple.value2,
            tuple.value3,
            tuple.value4,
          );
        }
      }
      for (String politicianWord in palavrasEsquerda) {
        final matriz = sequenceAlignment(word, politicianWord, 3, 2);
        final tuple = findSolution(matriz, word, politicianWord, 3, 2);
        //Compare Substitution count

        if (betterMatch == null ||
            tuple.value1 + tuple.value2 <
                betterMatch.substitutionCount + betterMatch.gapCount) {
          betterMatch = BetterMatch(
            PoliticianOption.esquerda,
            tuple.value1,
            tuple.value2,
            tuple.value3,
            tuple.value4,
          );
        }
      }
      for (String politicianWord in palavrasCentro) {
        final matriz = sequenceAlignment(word, politicianWord, 3, 2);
        final tuple = findSolution(matriz, word, politicianWord, 3, 2);
        //Compare Substitution count
        if (betterMatch == null ||
            tuple.value1 + tuple.value2 <
                betterMatch.substitutionCount + betterMatch.gapCount) {
          betterMatch = BetterMatch(
            PoliticianOption.centro,
            tuple.value1,
            tuple.value2,
            tuple.value3,
            tuple.value4,
          );
        }
      }
      betterMatches.add(betterMatch!);
    }

    final direitaMatches = betterMatches.where((element) {
      return element.politicianOption == PoliticianOption.direita;
    }).length;
    final esquerdaMatches = betterMatches
        .where(
            (element) => element.politicianOption == PoliticianOption.esquerda)
        .length;
    final centroMatches = betterMatches
        .where((element) => element.politicianOption == PoliticianOption.centro)
        .length;
    print(
        'direitaMatches: $direitaMatches, esquerdaMatches: $esquerdaMatches, centroMatches: $centroMatches');
    if (direitaMatches > esquerdaMatches && direitaMatches > centroMatches) {
      return const Right(PoliticianOption.direita);
    } else if (esquerdaMatches > direitaMatches &&
        esquerdaMatches > centroMatches) {
      return const Right(PoliticianOption.esquerda);
    } else {
      return const Right(PoliticianOption.centro);
    }
  }
}
