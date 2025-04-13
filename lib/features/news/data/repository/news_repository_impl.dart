import 'package:fpdart/fpdart.dart';
import 'package:newsy_app/core/error/failure.dart';
import 'package:newsy_app/core/utilities/type_def.dart';
import 'package:newsy_app/features/news/data/data_source/remote/news_remote_data_source.dart';
import 'package:newsy_app/features/news/domain/entities/news_response_entity.dart';
import 'package:newsy_app/features/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;

  NewsRepositoryImpl(this._newsRemoteDataSource);

  @override
  FutureEitherFailure<NewsResponseEntity?> getNews(int page, String category) async {
    try {
      final result = await _newsRemoteDataSource.getNews(page, category);
      return right(result?.toEntity());
    } catch (exception) {
      return left(Failure(exception.toString()));
    }
  }
}
