import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_clean/modules/search/domain/entities/result_search.dart';
import 'package:movies_clean/modules/search/domain/errors/errors.dart';
import 'package:movies_clean/modules/search/domain/usecases/search_by_text.dart';
import 'package:movies_clean/modules/search/presenter/blocs/search_bloc.dart';
import 'package:movies_clean/modules/search/presenter/blocs/states/state.dart';

class SearchByTextMock extends Mock implements SearchByText {}

void main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);
  test("Should Return The States Of Bloc in correct order", () {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    expect(bloc.stream,
        emitsInOrder([isA<SearchLoading>(), isA<SearchSuccess>()]));
    bloc.add("atsneves");
  });
}
