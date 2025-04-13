import 'package:newsy_app/features/news/data/models/news_response_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponseModel?> getNews(int page, String category);
}
