import 'package:bloc/bloc.dart';
import 'package:movies_clean/modules/search/domain/usecases/search_by_text.dart';
import 'package:movies_clean/modules/search/presenter/blocs/states/state.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchInitial()) {
    on<String>((event, emit) async {
      emit(SearchLoading());
      final result = await usecase(event);
      result.fold((l) => emit(SearchError(l)), (r) => emit(SearchSuccess(r!)));
    });
  }
}
