import 'package:newsy_app/features/news/data/models/news_model.dart';
import 'package:newsy_app/features/news/domain/entities/news_response_entity.dart';

class NewsResponseModel {
  final String? status;
  final int? totalResults;
  final List<NewsModel>? articles;

  NewsResponseModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: json['articles']?.map<NewsModel>((item) => NewsModel.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles,
    };
  }

  NewsResponseEntity toEntity(){
    return NewsResponseEntity(
      status: status,
      totalResults: totalResults,
      articles: articles?.map((e) => e.toEntity()).toList(),
    );
  }
}
