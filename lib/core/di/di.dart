import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newsy_app/features/news/data/data_source/remote/news_remote_data_source.dart';
import 'package:newsy_app/features/news/data/data_source/remote/news_remote_data_source_impl.dart';
import 'package:newsy_app/features/news/data/repository/news_repository_impl.dart';
import 'package:newsy_app/features/news/domain/repository/news_repository.dart';
import 'package:newsy_app/features/news/domain/usecase/get_news_usecase.dart';
import 'package:newsy_app/features/news/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:newsy_app/features/news/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:newsy_app/features/news/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:newsy_app/features/news/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  try {
    // Initialize SharedPreferences first
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);

    _registerDataSources();
    _registerRepositories();
    _registerUseCase();
    _registerBlocs();
  } catch (e) {
    debugPrint('Error initializing dependencies: $e');
  }
}

void _registerDataSources() {
  getIt.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl());
}

void _registerRepositories() {
  getIt.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(getIt()));
}

void _registerUseCase() {
  getIt.registerLazySingleton(() => GetNewsUseCase(getIt()));
}

void _registerBlocs() {
  getIt
    ..registerLazySingleton(() => DashboardBloc())
    ..registerLazySingleton(() => HomeBloc(getIt()))
    ..registerLazySingleton(() => SearchBloc(getIt(), getIt<SharedPreferences>()))
    ..registerLazySingleton(() => CategoryBloc());
}