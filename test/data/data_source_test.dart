import 'package:app/data/data_source.dart';
import 'package:app/politician_option.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('data source ...', () async {
    DataSource dataSource = DataSource();
    PoliticianOption? rightResponse;

    final response = dataSource.getPoliticianOption('igualdadw');

    response.fold(
      (l) => rightResponse = null,
      (r) => rightResponse = r,
    );

    expect(rightResponse, PoliticianOption.esquerda);
  });
}
