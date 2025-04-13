part of 'home_bloc.dart';

@immutable
class HomeState {
  final PageState pageState;
  final String? errorMessage;
  final int page;
  final String category;
  final bool loadMore;
  final List<NewsEntity> news;

  const HomeState({
    this.pageState = PageState.initial,
    this.errorMessage,
    this.page = 1,
    this.category = '',
    this.loadMore = false,
    this.news = const [],
  });

  HomeState copyWith({
    PageState? pageState,
    String? errorMessage,
    int? page,
    String? category,
    bool? loadMore,
    List<NewsEntity>? news,
  }) {
    return HomeState(
      pageState: pageState ?? this.pageState,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      category: category ?? this.category,
      loadMore: loadMore ?? this.loadMore,
      news: news ?? this.news,
    );
  }
}
