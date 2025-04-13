part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class InitialSearchEvent extends SearchEvent {}

final class NewsSearchEvent extends SearchEvent {}

final class GetNewsEvent extends SearchEvent {}

final class ScrolledEvent extends SearchEvent {
  final ScrollController controller;
  ScrolledEvent(this.controller);
}

class LoadRecentSearchesEvent extends SearchEvent {}

class AddRecentSearchEvent extends SearchEvent {
  final String query;
  AddRecentSearchEvent(this.query);
}

class RemoveRecentSearchEvent extends SearchEvent {
  final String query;
  RemoveRecentSearchEvent(this.query);
}

class ClearRecentSearchesEvent extends SearchEvent {}

class RefreshEvent extends SearchEvent {}
