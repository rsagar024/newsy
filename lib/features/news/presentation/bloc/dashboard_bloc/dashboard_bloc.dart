import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsy_app/core/resources/common/image_resources.dart';
import 'package:newsy_app/features/news/presentation/items/dashboard_item.dart';
import 'package:newsy_app/features/news/presentation/pages/category_page.dart';
import 'package:newsy_app/features/news/presentation/pages/home_page.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final List<DashboardItem> navItems = [
    DashboardItem(icon: ImageResources.iconHome, selectedIcon: ImageResources.iconHomeFill),
    DashboardItem(icon: ImageResources.iconCategory, selectedIcon: ImageResources.iconCategoryFill),
    DashboardItem(icon: ImageResources.iconBookmark, selectedIcon: ImageResources.iconBookmarkFill),
    DashboardItem(icon: ImageResources.iconProfile, selectedIcon: ImageResources.iconProfileFill),
  ];

  final List<Widget> navWidgets = [
    const HomePage(),
    const CategoryPage(),
    const Center(
      child: Text(
        'Bookmark',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        'Profile',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ),
  ];

  DashboardBloc() : super(const DashboardState()) {
    on<InitialDashboardEvent>(_onInitialDashboard);
    on<NavigationToggleEvent>(_onNavigationToggle);
    on<PageChangedEvent>(_onPageChanged);
  }

  FutureOr<void> _onInitialDashboard(InitialDashboardEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(page: 0));
  }

  FutureOr<void> _onNavigationToggle(NavigationToggleEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(page: event.index));
    event.pageController.jumpToPage(event.index);
  }

  FutureOr<void> _onPageChanged(PageChangedEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(page: event.index));
  }
}
