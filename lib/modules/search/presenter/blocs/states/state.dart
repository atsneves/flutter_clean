import 'dart:ffi';

import 'package:movies_clean/modules/search/domain/entities/result_search.dart';
import 'package:movies_clean/modules/search/domain/errors/errors.dart';

abstract class SearchState {
  const SearchState();
}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final FailureSearch failureSearch;
  const SearchError(this.failureSearch);
}

class SearchSuccess extends SearchState {
  final List<ResultSearch> list;
  const SearchSuccess(this.list);
}

class SearchInitial extends SearchState {}
