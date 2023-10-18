import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_clean/modules/search/domain/repositories/search_repository.dart';
import 'package:movies_clean/modules/search/domain/usecases/search_by_text.dart';
import 'package:movies_clean/modules/search/external/datasources/github_datasource.dart';
import 'package:movies_clean/modules/search/infra/datasources/result_search_datasource.dart';
import 'package:movies_clean/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:movies_clean/modules/search/presenter/blocs/search_bloc.dart';
import 'package:movies_clean/modules/search/presenter/pages/search_page.dart';

// Dependency Injection
class AppModule extends Module {
  @override
  void binds(i) {
    i.addInstance<Dio>(Dio());
    i.add<SearchBloc>(SearchBloc.new);
    i.add<SearchRepository>(SearchRepositoryImpl.new);
    i.add<SearchByText>(SearchByTextImpl.new);
    i.add<SearchDataSource>(GithubDatasource.new);
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => const SearchPage());
  }
}
