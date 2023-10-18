import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_clean/modules/search/domain/entities/result_search.dart';
import 'package:movies_clean/modules/search/domain/errors/errors.dart';
import 'package:movies_clean/modules/search/infra/datasources/result_search_datasource.dart';
import 'package:movies_clean/modules/search/infra/model/result_search_model.dart';
import 'package:movies_clean/modules/search/infra/repositories/search_repository_impl.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

void main() {
  final datasource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(datasource);
  test('Should Return a list of ResultSearchModel', () async {
    when(() => datasource.getSearch(any()))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search("atsneves");

    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Should Return an error if datasource is failed', () async {
    when(() => datasource.getSearch(any())).thenThrow(Exception());

    final result = await repository.search("atsneves");

    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
