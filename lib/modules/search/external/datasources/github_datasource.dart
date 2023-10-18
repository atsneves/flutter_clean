import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_clean/modules/search/domain/errors/errors.dart';
import 'package:movies_clean/modules/search/infra/datasources/result_search_datasource.dart';
import 'package:movies_clean/modules/search/infra/model/result_search_model.dart';

extension on String {
  normalize() {
    return replaceAll(" ", "+");
  }
}

class GithubDatasource implements SearchDataSource {
  final Dio dio;

  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final path =
        "https://api.github.com/search/users?q=${searchText.normalize()}";
    final response = await dio.get(path);

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e))
          .toList();

      return list;
    } else {
      throw DatasourceError();
    }
  }
}
