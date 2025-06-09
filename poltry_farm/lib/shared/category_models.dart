import 'package:equatable/equatable.dart';

class PfCategoryModel extends Equatable {
  final String name;
  final String? description;
  final String? imageUrl;

  const PfCategoryModel({
    required this.name,
    this.description,
    this.imageUrl,
  });

  factory PfCategoryModel.fromJson(Map<String, dynamic> json) {
    return PfCategoryModel(
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  PfCategoryModel copyWith({
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return PfCategoryModel(
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [name, description, imageUrl];
}
