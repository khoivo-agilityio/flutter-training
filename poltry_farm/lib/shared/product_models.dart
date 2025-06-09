import 'package:equatable/equatable.dart';

class PfProductModel extends Equatable {
  final String name;
  final String? description;
  final double? price;
  final String? imageUrl;

  const PfProductModel({
    required this.name,
    this.description,
    this.price,
    this.imageUrl,
  });

  factory PfProductModel.fromJson(Map<String, dynamic> json) {
    return PfProductModel(
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  PfProductModel copyWith({
    String? name,
    String? description,
    double? price,
    String? imageUrl,
  }) {
    return PfProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [name, description, price, imageUrl];
}
