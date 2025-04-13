part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class InitialDashboardEvent extends DashboardEvent {}

final class NavigationToggleEvent extends DashboardEvent {
  final int index;
  final PageController pageController;
  NavigationToggleEvent(this.index, this.pageController);
}

final class PageChangedEvent extends DashboardEvent {
  final int index;
  PageChangedEvent(this.index);
}
