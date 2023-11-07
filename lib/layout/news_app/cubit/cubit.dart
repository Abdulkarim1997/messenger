// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:messenger/layout/news_app/cubit/states.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/scinence/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shard/network/rmote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: "Business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "Sport",
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "Science",
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 1) getSports();
    // if (index == 2) getScience();
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '6a9066e9164e4437a9389c06b869642a',
    }).then((value) {
      business = value!.data["articles"];
      // ignore: avoid_print
      print(business[0]["title"]);
      emit(NewsGetBusinessSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingStates());
    if (sports.isEmpty) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '6a9066e9164e4437a9389c06b869642a',
      }).then((value) {
        sports = value!.data["articles"];
        print(sports[0]["title"]);
        emit(NewsGetSportsSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessStates());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingStates());
    if (science.isEmpty) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '6a9066e9164e4437a9389c06b869642a',
      }).then((value) {
        science = value!.data["articles"];
        print(science[0]["title"]);
        emit(NewsGetScienceSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessStates());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingStates());

    DioHelper.getData(path: '/v2/everything', query: {
      'q': value,
      'apiKey': '6a9066e9164e4437a9389c06b869642a',
    }).then((value) {
      search = value!.data["articles"];
      print(search[0]["title"]);
      emit(NewsGetSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }
}
