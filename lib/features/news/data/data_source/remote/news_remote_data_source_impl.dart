import 'package:newsy_app/core/remote/news_rest_service.dart';
import 'package:newsy_app/core/resources/common/rest_resources.dart';
import 'package:newsy_app/features/news/data/data_source/remote/news_remote_data_source.dart';
import 'package:newsy_app/features/news/data/models/news_response_model.dart';

class NewsRemoteDataSourceImpl extends NewsRestService implements NewsRemoteDataSource {
  @override
  Future<NewsResponseModel?> getNews(int page, String category) async {
    final restResponse = createGetRequest(NewsRestResources.getNews(page, category));
    final response = await executeRequestAsync<NewsResponseModel>(
      restResponse,
      (json) => NewsResponseModel.fromJson(json),
    );
    return response;
  }
}
