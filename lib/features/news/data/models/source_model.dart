import 'package:newsy_app/features/news/domain/entities/source_entity.dart';

class SourceModel {
  final String? id;
  final String? name;

  SourceModel({
    this.id,
    this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  SourceEntity toEntity() {
    return SourceEntity(
      id: id,
      name: name,
    );
  }
}
