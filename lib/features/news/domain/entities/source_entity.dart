import 'package:newsy_app/features/news/data/models/source_model.dart';

class SourceEntity {
  final String? id;
  final String? name;

  SourceEntity({
    this.id,
    this.name,
  });

  SourceModel toModel() {
    return SourceModel(
      id: id,
      name: name,
    );
  }
}
