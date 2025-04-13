import 'package:newsy_app/core/utilities/type_def.dart';
import 'package:newsy_app/features/news/domain/entities/news_response_entity.dart';

abstract class NewsRepository {
  FutureEitherFailure<NewsResponseEntity?> getNews(int page, String category);
}
