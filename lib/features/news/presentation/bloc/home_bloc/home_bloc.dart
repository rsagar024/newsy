import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsy_app/core/enums/app_enum/page_state_enum.dart';
import 'package:newsy_app/features/news/domain/entities/news_entity.dart';
import 'package:newsy_app/features/news/domain/usecase/get_news_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNewsUseCase _getNewsUseCase;

  HomeBloc(this._getNewsUseCase) : super(const HomeState()) {
    on<InitialHomeEvent>(_onInitialHome);
    on<GetNewsEvent>(_onGetNews);
    on<ToggleCategoryEvent>(_onToggleCategory);
    on<ScrolledEvent>(_onScrolled);
    on<RefreshEvent>(_onRefresh);
  }

  FutureOr<void> _onInitialHome(InitialHomeEvent event, Emitter<HomeState> emit) {
    emit(const HomeState());
  }

  FutureOr<void> _onGetNews(GetNewsEvent event, Emitter<HomeState> emit) async {
    final List<NewsEntity> entities = state.news;
    final newsResponse = await _getNewsUseCase.call(GetNewsUseCaseParam(state.page, event.category.toLowerCase()));
    newsResponse.fold(
      (failure) {
        emit(state.copyWith(
          pageState: PageState.failure,
          errorMessage: failure.message,
          loadMore: false,
          category: event.category.toLowerCase(),
        ));
      },
      (success) {
        emit(state.copyWith(
          pageState: PageState.success,
          news: [...entities, ...?success?.articles],
          page: state.page + 1,
          loadMore: false,
          category: event.category.toLowerCase(),
        ));
      },
    );
  }

  FutureOr<void> _onToggleCategory(ToggleCategoryEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      category: event.category.toLowerCase(),
      news: [],
      page: 1,
      pageState: PageState.loading,
    ));
    add(GetNewsEvent(event.category));
  }

  FutureOr<void> _onScrolled(ScrolledEvent event, Emitter<HomeState> emit) async {
    if (state.loadMore) return;
    if (event.controller.position.pixels >= event.controller.position.maxScrollExtent * 0.6) {
      if (state.page <= 5) {
        emit(state.copyWith(loadMore: true));
        add(GetNewsEvent(state.category));
      }
    }
  }

  FutureOr<void> _onRefresh(RefreshEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(news: [], pageState: PageState.loading, page: 1));
    add(GetNewsEvent(state.category));
  }
}
