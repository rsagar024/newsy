import 'package:newsy_app/core/utilities/type_def.dart';

abstract class UseCase<Success, Params> {
  FutureEitherFailure<Success> call(Params params);
}

class NoParams {}
