import 'package:newsy_app/core/common/base/usecase/use_case.dart';
import 'package:newsy_app/core/utilities/type_def.dart';
import 'package:newsy_app/features/news/domain/entities/news_response_entity.dart';
import 'package:newsy_app/features/news/domain/repository/news_repository.dart';

class GetNewsUseCase implements UseCase<NewsResponseEntity?, GetNewsUseCaseParam> {
  final NewsRepository _newsRepository;

  GetNewsUseCase(this._newsRepository);

  @override
  FutureEitherFailure<NewsResponseEntity?> call(params) async {
    return await _newsRepository.getNews(params.page, params.category);
  }
}

class GetNewsUseCaseParam {
  final int page;
  final String category;

  GetNewsUseCaseParam(this.page, this.category);
}
