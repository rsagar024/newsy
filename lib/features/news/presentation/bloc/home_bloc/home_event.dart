part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class InitialHomeEvent extends HomeEvent {}

final class GetNewsEvent extends HomeEvent {
  final String category;
  GetNewsEvent(this.category);
}

final class ToggleCategoryEvent extends HomeEvent {
  final String category;
  ToggleCategoryEvent(this.category);
}

final class ScrolledEvent extends HomeEvent {
  final ScrollController controller;
  ScrolledEvent(this.controller);
}

final class RefreshEvent extends HomeEvent {}
