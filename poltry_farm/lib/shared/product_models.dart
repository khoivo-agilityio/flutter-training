import 'package:equatable/equatable.dart';

class PfProductModel extends Equatable {
  final String name;
  final String? description;
  final double? price;
  final String? imageUrl;
  final int? quantity;
  final String? location;

  const PfProductModel({
    required this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.quantity,
    this.location,
  });

  factory PfProductModel.fromJson(Map<String, dynamic> json) {
    return PfProductModel(
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      quantity: json['quantity'] as int?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'location': location,
    };
  }

  PfProductModel copyWith({
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? quantity,
    String? location,
  }) {
    return PfProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props =>
      [name, description, price, imageUrl, quantity, location];
}
