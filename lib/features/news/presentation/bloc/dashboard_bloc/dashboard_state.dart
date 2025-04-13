part of 'dashboard_bloc.dart';

class DashboardState {
  final int page;

  const DashboardState({this.page = 0});

  DashboardState copyWith({
    int? page,
  }) {
    return DashboardState(
      page: page ?? this.page,
    );
  }
}
