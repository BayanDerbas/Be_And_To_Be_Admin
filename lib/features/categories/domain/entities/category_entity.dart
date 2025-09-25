import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final int branch_id;
  final String created_at;
  final String updated_at;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.branch_id,
    required this.created_at,
    required this.updated_at,
  });

  @override
  List<Object?> get props => [id, name, image, branch_id];
}
