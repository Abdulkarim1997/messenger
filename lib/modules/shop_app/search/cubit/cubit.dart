import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/models/shop_app/search_model.dart';
import 'package:messenger/modules/shop_app/search/cubit/states.dart';
import 'package:messenger/shard/network/rmote/dio_helper.dart';

import '../../../../shard/components/constants.dart';
import '../../../../shard/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(token: token, path: SEARCH, data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccesscState());
    }).catchError((error) {
      print(error.toString);
      emit(SearchErrorState());
    });
  }
}
