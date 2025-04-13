part of 'search_bloc.dart';

@immutable
class SearchState {
  final PageState pageState;
  final String? errorMessage;
  final int page;
  final bool loadMore;
  final List<NewsEntity> news;
  final List<String> recentSearches;

  const SearchState({
    this.pageState = PageState.initial,
    this.errorMessage,
    this.page = 1,
    this.loadMore = false,
    this.news = const [],
    this.recentSearches = const [],
  });

  SearchState copyWith({
    PageState? pageState,
    String? errorMessage,
    int? page,
    bool? loadMore,
    List<NewsEntity>? news,
    List<String>? recentSearches,
  }) {
    return SearchState(
      pageState: pageState ?? this.pageState,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      loadMore: loadMore ?? this.loadMore,
      news: news ?? this.news,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }
}
