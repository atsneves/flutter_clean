import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_clean/modules/search/domain/errors/errors.dart';
import 'package:movies_clean/modules/search/external/datasources/github_datasource.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  final datasources = GithubDatasource(dio);
  test("should return a list of ResultSearchModel", () {
    when(() => dio.get(any())).thenAnswer((_) async => Response(
        data: jsonDecode(githubResponse),
        statusCode: 200,
        requestOptions: RequestOptions(path: "")));

    final future = datasources.getSearch("searchText");
    expect(future, completes);
  });

  test("should return a Error with code isn't 200", () {
    when(() => dio.get(any())).thenAnswer((_) async => Response(
        data: null, statusCode: 401, requestOptions: RequestOptions(path: "")));

    final future = datasources.getSearch("searchText");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("should return a Error in a DIO", () {
    when(() => dio.get(any())).thenThrow(Exception());

    final future = datasources.getSearch("searchText");
    expect(future, throwsA(isA<Exception>()));
  });
}
