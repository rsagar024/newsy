import 'package:newsy_app/features/news/data/models/news_response_model.dart';
import 'package:newsy_app/features/news/domain/entities/news_entity.dart';

class NewsResponseEntity{
  final String? status;
  final int? totalResults;
  final List<NewsEntity>? articles;

  NewsResponseEntity({
    this.status,
    this.totalResults,
    this.articles,
  });

  NewsResponseModel toModel(){
    return NewsResponseModel(
      status: status,
      totalResults: totalResults,
      articles: articles?.map((e) => e.toModel()).toList(),
    );
  }
}