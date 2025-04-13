import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsy_app/core/enums/app_enum/page_state_enum.dart';
import 'package:newsy_app/features/news/domain/entities/news_entity.dart';
import 'package:newsy_app/features/news/domain/usecase/get_news_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TextEditingController? searchController;
  Timer? _debounce;
  final GetNewsUseCase _getNewsUseCase;
  final SharedPreferences _prefs;

  SearchBloc(this._getNewsUseCase, this._prefs) : super(const SearchState()) {
    on<InitialSearchEvent>(_onInitialSearch);
    on<NewsSearchEvent>(_onNewsSearch);
    on<GetNewsEvent>(_onGetNews);
    on<ScrolledEvent>(_onScrolled);
    on<LoadRecentSearchesEvent>(_onLoadRecentSearches);
    on<AddRecentSearchEvent>(_onAddRecentSearch);
    on<RemoveRecentSearchEvent>(_onRemoveRecentSearch);
    on<ClearRecentSearchesEvent>(_onClearRecentSearches);
    on<RefreshEvent>(_onRefresh);
  }

  void initializeController() {
    searchController = TextEditingController();
  }

  void disposeController() {
    searchController?.dispose();
  }

  FutureOr<void> _onInitialSearch(InitialSearchEvent event, Emitter<SearchState> emit) {
    searchController?.clear();
    emit(const SearchState());
  }

  FutureOr<void> _onNewsSearch(NewsSearchEvent event, Emitter<SearchState> emit) async {
    _debounce?.cancel();
    if (searchController?.text.isNotEmpty ?? false) {
      emit(state.copyWith(pageState: PageState.loading, page: 1, news: []));
    } else {
      emit(state.copyWith(pageState: PageState.initial));
    }
    _debounce = Timer(const Duration(milliseconds: 900), () {
      if (searchController?.text.isNotEmpty ?? false) {
        add(GetNewsEvent());
        add(AddRecentSearchEvent(searchController!.text));
      }
    });
  }

  FutureOr<void> _onGetNews(GetNewsEvent event, Emitter<SearchState> emit) async {
    final List<NewsEntity> entities = state.news;
    final newsResponse = await _getNewsUseCase.call(GetNewsUseCaseParam(state.page, searchController?.text ?? ''));

    newsResponse.fold(
      (failure) {
        emit(state.copyWith(
          pageState: PageState.failure,
          errorMessage: failure.message,
          loadMore: false,
        ));
      },
      (success) {
        emit(state.copyWith(
          pageState: PageState.success,
          news: [...entities, ...?success?.articles],
          page: state.page + 1,
          loadMore: false,
        ));
      },
    );
  }

  FutureOr<void> _onScrolled(ScrolledEvent event, Emitter<SearchState> emit) async {
    if (state.loadMore) return;
    if (event.controller.position.pixels >= event.controller.position.maxScrollExtent * 0.6) {
      if (state.page <= 5) {
        emit(state.copyWith(loadMore: true));
        add(GetNewsEvent());
      }
    }
  }

  FutureOr<void> _onLoadRecentSearches(LoadRecentSearchesEvent event, Emitter<SearchState> emit) async {
    final recentSearches = _prefs.getStringList('recentSearches') ?? [];
    emit(state.copyWith(recentSearches: recentSearches));
  }

  FutureOr<void> _onAddRecentSearch(AddRecentSearchEvent event, Emitter<SearchState> emit) async {
    if (event.query.trim().isEmpty) return;

    final newRecentSearches = [event.query, ...state.recentSearches.where((item) => item != event.query)].take(5).toList();

    await _prefs.setStringList('recentSearches', newRecentSearches);
    emit(state.copyWith(recentSearches: newRecentSearches));
  }

  FutureOr<void> _onRemoveRecentSearch(RemoveRecentSearchEvent event, Emitter<SearchState> emit) async {
    final newRecentSearches = state.recentSearches.where((item) => item != event.query).toList();
    await _prefs.setStringList('recentSearches', newRecentSearches);
    emit(state.copyWith(recentSearches: newRecentSearches));
  }

  FutureOr<void> _onClearRecentSearches(ClearRecentSearchesEvent event, Emitter<SearchState> emit) async {
    await _prefs.remove('recentSearches');
    emit(state.copyWith(recentSearches: []));
  }

  FutureOr<void> _onRefresh(RefreshEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(news: [], pageState: PageState.loading, page: 1));
    add(GetNewsEvent());
  }
}
