import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_clean/app_module.dart';
import 'package:movies_clean/modules/search/domain/entities/result_search.dart';
import 'package:movies_clean/modules/search/domain/usecases/search_by_text.dart';

import 'modules/search/utils/github_response.dart';

class DioMock extends Mock implements DioForNative {}

void main() {
  final dioMock = DioMock();

  test("should get use case", () {
    Modular.bindModule(AppModule());
    Modular.replaceInstance<Dio>(dioMock);

    final usecase = Modular.get<SearchByText>();

    expect(usecase, isA<SearchByTextImpl>());
  });

  test("should return a list ResultSearch", () async {
    Modular.bindModule(AppModule());

    when(() => dioMock.get(any())).thenAnswer((_) async => Response(
        data: jsonDecode(githubResponse),
        statusCode: 200,
        requestOptions: RequestOptions(path: "")));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("atsneves");
    expect(result | null, isA<List<ResultSearch>>());
  });
}
