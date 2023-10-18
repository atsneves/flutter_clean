import 'package:dartz/dartz.dart';
import 'package:movies_clean/modules/search/domain/entities/result_search.dart';
import 'package:movies_clean/modules/search/domain/errors/errors.dart';
import 'package:movies_clean/modules/search/domain/repositories/search_repository.dart';
import 'package:movies_clean/modules/search/infra/datasources/result_search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>?>> search(
      String searchText) async {
    try {
      final result = await dataSource.getSearch(searchText);

      return Right(result);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
