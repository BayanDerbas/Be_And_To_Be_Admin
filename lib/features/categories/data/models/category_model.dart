import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/category_entity.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends CategoryEntity {
  final int id;
  final String name;
  final String image;
  @JsonKey(name: 'branch_id')
  final int branch_id;
  @JsonKey(name: 'created_at')
  final String created_at;
  @JsonKey(name: 'updated_at')
  final String updated_at;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.branch_id,
    required this.created_at,
    required this.updated_at,
  }) : super(
    id: id,
    name: name,
    image: image,
    branch_id: branch_id,
    created_at: created_at,
    updated_at: updated_at,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class CategoriesResponseModel {
  @JsonKey(name: 'All Categories')
  final List<CategoryModel> categories;

  CategoriesResponseModel({required this.categories});

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseModelFromJson(json);
}
