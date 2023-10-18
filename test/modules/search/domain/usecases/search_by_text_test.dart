import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_clean/modules/search/domain/entities/result_search.dart';
import 'package:movies_clean/modules/search/domain/errors/errors.dart';
import 'package:movies_clean/modules/search/domain/repositories/search_repository.dart';
import 'package:movies_clean/modules/search/domain/usecases/search_by_text.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

void main() {
  final repository = SearchRepositoryMock();

  final usecase = SearchByTextImpl(repository);

  test('should return a list of ResultSearch', () async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await usecase("anderson");

    expect(result | null, isA<List<ResultSearch>>());
  });

  test('should return invalid list', () async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    var result = await usecase("");

    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
