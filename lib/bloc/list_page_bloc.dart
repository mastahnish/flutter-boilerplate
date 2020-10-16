import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htd_poc/model/list_element_model.dart';

part 'list_page_event.dart';
part 'list_page_state.dart';

class ListPageBloc extends Bloc<ListPageEvent, ListPageState> {
  ListPageBloc() : super(ListPageState.initial());

  @override
  Stream<ListPageState> mapEventToState(ListPageEvent event) async* {
    if (event is _LoadNextPageEvent) {
      // TODO
      print('bloc');
    }
  }
}
