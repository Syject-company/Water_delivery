import 'package:equatable/equatable.dart';

class CategoryFields {
  static const String id = 'id';
  static const String imageUri = 'imageUri';
  static const String title = 'title';
}

class Category extends Equatable {
  const Category({
    required this.id,
    required this.imageUri,
    required this.title,
  });

  final String id;
  final String imageUri;
  final String title;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json[CategoryFields.id],
      imageUri: json[CategoryFields.imageUri],
      title: json[CategoryFields.title],
    );
  }

  @override
  List<Object> get props => [
        id,
        imageUri,
        title,
      ];
}
